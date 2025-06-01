import SwiftUI

struct AdminView: View {
    @EnvironmentObject var drawingModel: DrawingModel
    @Environment(\.presentationMode) var presentationMode // To dismiss the sheet
    
    // State variable to control the presentation of the confirmation alert
    @State private var showingDeleteAllAlert = false
    
    var body: some View {
        // Use ZStack for background image
        ZStack {
            Image("LibraryViewBackground") // Use LibraryViewBackground or another suitable image
                .resizable()
                .ignoresSafeArea()
            
            NavigationView { // Use NavigationView for a title and potential future bar items
                VStack {
                    if drawingModel.savedDrawings.isEmpty {
                        Text("저장된 그림이 없습니다.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        // Create the List
                        let drawingList = List { // Use List to display the drawings
                            ForEach(drawingModel.savedDrawings.indices, id: \.self) { index in
                                // Use the extracted helper view for each row
                                AdminDrawingRow(image: drawingModel.savedDrawings[index], index: index)
                            }
                            // Add onDelete modifier for swipe-to-delete functionality
                            .onDelete(perform: deleteDrawing)
                        }
                        
                        // Conditionally apply the background modifier based on availability
                        #if !os(watchOS)
                        if #available(iOS 16.0, *) {
                            drawingList
                                .scrollContentBackground(.hidden) // For iOS 16+
                        } else {
                            // Fallback for older iOS versions if needed, often requires listRowBackground
                            drawingList
                        }
                        #else
                        // For watchOS, just use the list without the modifier
                        drawingList
                        #endif
                        // .listRowBackground(Color.clear) // Alternative/For older iOS versions - apply to rows if needed
                    }
                    
                    Spacer() // Pushes content to the top
                    
                    // Button to delete all drawings
                    Button("전체 그림 삭제") {
                        // Show confirmation alert
                        showingDeleteAllAlert = true
                    }
                    .foregroundColor(.red)
                    .padding()
                    // Add confirmation alert
                    .alert(isPresented: $showingDeleteAllAlert) {
                        Alert(
                            title: Text("전체 그림 삭제"),
                            message: Text("모든 그림을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다."),
                            primaryButton: .destructive(Text("삭제")) {
                                // Delete all drawings
                                drawingModel.savedDrawings.removeAll()
                                drawingModel.saveChanges() // Save changes after deletion
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .navigationTitle("어드민 페이지") // Title for the admin page
                .navigationBarItems(trailing: Button("완료") { // Done button to dismiss
                    presentationMode.wrappedValue.dismiss()
                })
            }
            // Make NavigationView background clear
            .navigationViewStyle(.stack) // Ensure stack style for proper background handling
            .background(Color.clear) // Ensure NavigationView background is clear
        }
    }
    
    // Helper function for swipe-to-delete
    func deleteDrawing(at offsets: IndexSet) {
        drawingModel.savedDrawings.remove(atOffsets: offsets)
        drawingModel.saveChanges() // Save changes after deletion
    }
}

// Helper view for displaying a single drawing row in the admin list
struct AdminDrawingRow: View {
    let image: UIImage
    let index: Int
    
    var body: some View {
        HStack {
            Text("그림 \(index + 1)")
            
            // Display a small preview of the drawing
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            
            Spacer()
            
            // Individual delete button is removed, using List's onDelete instead
        }
    }
}

// Preview Provider
struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
            // Provide a mock DrawingModel for the preview
            .environmentObject(DrawingModel())
    }
} 
