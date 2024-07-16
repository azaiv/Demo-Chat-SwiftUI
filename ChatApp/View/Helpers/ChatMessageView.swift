import SwiftUI

struct ChatMessageView: View {
    
    let text: String
    
    var body: some View {
        
        Text(text)
            .foregroundStyle(.white)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(content: {
                RoundedRectangle(
                    cornerRadius: 15,
                    style: .continuous)
                .foregroundStyle(.blue)
            })
    }
    
}

#Preview {
    ChatMessageView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
}
