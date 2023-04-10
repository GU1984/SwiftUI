//
//  ScannerView.swift
//  QRCodeScanner
//
//  Created by Георгий Усынин on 10.04.2023.
//

import SwiftUI
import AVKit

struct ScannerView: View {
    
    @State private var isScaning: Bool = false
    @State private var session: AVCaptureSession = .init()
    
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var cameraPermission: Permission = .idle
    
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    @Environment(\.openURL) private var openURL
    
    @StateObject private var qrDelegate = QRScannerDelegate()
    
    @State private var scannedCode: String = ""
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("Place QR code inside the area")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 20)
            
            Text("Scanning will start automaticly")
                .font(.callout)
                .foregroundColor(.gray)
            
            Spacer(minLength: 0)
            
            GeometryReader{
                let size = $0.size
                
              
                
                ZStack {
                    
                    CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                        .scaleEffect(0.97)
                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .trim(from: 0.61, to: 0.64)
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                        
                    }
               
                       
                    
                }
                .frame(width: size.width, height: size.width)
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 2.5)
                        .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: 10)
                        .offset(y: isScaning ? size.width : 0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 45)
            
            
            
            Spacer(minLength: 15)
            
            Button {
                if !session.isRunning && cameraPermission == .approved {
                    scannedCode = ""
                    reacivateCamera()
                    activeScannerAnimation()
                }
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            Text("Scanned code: \(scannedCode)")
            
            Spacer(minLength: 45)
        }
        .padding(15)
        .onAppear(perform: {
            checkCameraPermission()
        })
        .alert(errorMessage, isPresented: $showError) {
            if cameraPermission == .denied {
                Button("Settings") {
                    let settingsString = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settingsString) {
                        openURL(settingsURL)
                    }
                }
                
                Button("Cancel", role: .cancel) {
                    
                }
            }
        }
        
        .onChange(of: qrDelegate.scannedCode) { newValue in
            if let code = newValue {
                scannedCode = code
                
                // When the first code scan is available. immediatly stop the camers
                session.stopRunning()
                //Stop animation
                deActiveScannerAnimation()
                // Clearing the data on delegate
                qrDelegate.scannedCode = nil
              
            }
        }
    }
    
    func reacivateCamera() {
        DispatchQueue.global(qos: .background).async{
            session.startRunning()
        }
    }
    
    func activeScannerAnimation() {
        withAnimation(.easeOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScaning = true
        }
    }
    
    func deActiveScannerAnimation() {
        withAnimation(.easeOut(duration: 0.85)) {
            isScaning = false
        }
    }
    
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    session.startRunning()
                }
                
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                } else {
                    cameraPermission = .denied
                    presentError("Please Provide Access to Camera for scaning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for scaning codes")
            default: break
            }
        }
    }
    
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInUltraWideCamera, .builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("Unknown Device Error")
                return
            }
          
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("Unknown Input / Output Error")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
    
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activeScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
