//
//  RoomCaptureView.swift
//  Home
//
//  Created by Ålex on 18/02/2023.
//

import SwiftUI

struct RoomPlanView: View {
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(systemName: "house")
                    .foregroundColor(.primary)
                    .font(.system(size: 40))
                    .padding(.bottom)
                
                Spacer().frame(height: 40)
                Text("roomplan_description")
                Spacer()
                
                NavigationLink {
                    ScanningView()
                } label: {
                    ZStack {
                        if isLoading {
                            ProgressView()
                        } else {
                            Text("roomplan_action_start")
                        }
                    }
                }
                .disabled(isLoading)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor, in: Capsule())
                .foregroundColor(.white)
                .font(.title2)
            
                
            }
            .padding()
            .navigationTitle("roomplan_title")
        }
    }
}

struct RoomPlan_Previews: PreviewProvider {
    static var previews: some View {
        RoomPlanView()
    }
}


struct RoomCaptureViewRep : UIViewRepresentable
{
    func makeUIView(context: Context) -> some UIView {
        RoomCaptureController.instance.roomCaptureView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct ActivityViewControllerRep: UIViewControllerRepresentable {
    var items: [Any]
    var activities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewControllerRep>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: activities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewControllerRep>) {}
}

struct ScanningView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var captureController = RoomCaptureController.instance
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoomCaptureViewRep()
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button("cancel") {
                    captureController.stopSession()
                    dismiss()
                })
                .navigationBarItems(trailing: Button("done") {
                    captureController.stopSession()
                    captureController.showExportButton = true
                }.opacity(captureController.showExportButton ? 0 : 1))
                .onAppear() {
                    captureController.showExportButton = false
                    captureController.startSession()
                }
            
            
            Button(action: {
                captureController.save()
                dismiss()
            }, label: {
                Text("roomplan_action_save").font(.title2)
            }).buttonStyle(.borderedProminent).cornerRadius(40).opacity(captureController.showExportButton ? 1 : 0).padding().sheet(isPresented: $captureController.showShareSheet, content:{
                ActivityViewControllerRep(items: [captureController.exportUrl!])
            })
        }
    }
}
