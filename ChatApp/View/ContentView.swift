import SwiftUI

struct ContentView: View {
    
    @State private var chatMessages: [ChatModel] = [
        .init(author: "John", textMessage: "first", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "John", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "John", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "Alex", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "Alex", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "last", date: .now),
        .init(author: "John", textMessage: "first", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "John", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "John", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "Alex", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "Alex", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "Whats up?", date: .now),
        .init(author: "John", textMessage: "Hello!", date: .now),
        .init(author: "Alex", textMessage: "last", date: .now),
    ]
    @State private var lastElement: UUID? = nil
    
    @State private var message: String = ""
    @State private var sendMessage: Bool = false
    @FocusState private var textfieldFocus
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView(content: {
                    ScrollViewReader { sr in
                        LazyVStack(alignment: .leading) {
                            ForEach(chatMessages, id: \.id) { author in
                                if author.author == "John" {
                                    ChatMessageView(text: author.textMessage)
                                        .padding(.leading)
                                } else {
                                    HStack {
                                        Spacer()
                                        ChatMessageView(text: author.textMessage)
                                            .padding(.trailing)
                                    }
                                }
                            }
                        }
                        .onAppear(perform: {
                            DispatchQueue.main.async {
                                sr.scrollTo(chatMessages.last!.id)
                            }
                        })
                        .frame(minHeight: reader.size.height, alignment: .bottom)
                        .onChange(of: sendMessage) { value in
                            if value {
                                chatMessages.append(
                                    .init(author: "Alex",
                                          textMessage: message,
                                          date: .now))
                                
                                message = ""
                                DispatchQueue.main.async {
                                    withAnimation(.easeIn, {
                                        sr.scrollTo(chatMessages.last!.id)
                                    })
                                    sendMessage = false
                                }
                            }
                        }
                        .onChange(of: textfieldFocus) { value in
                            if value {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                    withAnimation(.easeIn, {
                                        sr.scrollTo(chatMessages.last!.id)
                                    })
                                })
                                
                            } else {
                                print("not focus")
                            }
                        }
                    }
                })
                .onTapGesture {
                    textfieldFocus = false
                }
            }
            .navigationTitle("Chat")
            #if os(iOS)
            .toolbarBackground(.white, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .safeAreaInset(edge: .bottom, content: {
                VStack{
                    Divider()
                    HStack {
                        TextField("Write Message", text: $message)
                            .foregroundStyle(.black)
                            .padding(10)
                            .background(content: {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundStyle(.secondary.opacity(0.2))
                            })
                            .focused($textfieldFocus)
                            .textFieldStyle(.plain)
                        
                        Button(action: {
                            if !message.isEmpty {
                                sendMessage = true
                            }
                        }, label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .foregroundStyle(.blue)
                        })
                        .buttonStyle(.plain)
                    }
                    .padding(.top, 2)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
                .background(content: {
                    #if os(macOS)
                    Color(nsColor: NSColor.controlBackgroundColor)
                        .ignoresSafeArea()
                    #else
                    Color(uiColor: .systemBackground)
                        .ignoresSafeArea()
                    #endif
                })
            })
        }
    }
    
}

#Preview {
    ContentView()
}
