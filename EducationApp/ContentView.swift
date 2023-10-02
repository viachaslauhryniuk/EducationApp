//TODO:  score show
import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var b:Int // number of questions
    @Binding var num:Int //table size
    @State var answer = ""
    @State var alertText = ""
    @State var alertMessage = ""
    @State var next = false
    @State var a = Int.random(in: 0...2)
    @State var c = Int.random(in: 0...2)
    @State var roundcount = 0

    var body: some View {

        NavigationStack{
            ZStack{
                Rectangle()
                    .fill(LinearGradient(colors: [.cyan, .indigo], startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                 
                VStack{
                  
                    Spacer()
                    
                            Text("\(a) × \(c) = ")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .fontWidth(.expanded)
                                .fontDesign(.monospaced)
                      
                 
                    TextField("Enter your answer here", text: $answer)
                        
                                .keyboardType(.numberPad)
                                .disableAutocorrection(true)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                    
                    Spacer()
                    Spacer()
                        
                    }
                }
            }
                
                .alert(alertText, isPresented: $next) {
                    Button("OK"){
                        next = false
                        roundcount += 1
                        if roundcount == b {
                            dismiss()
                            b = 5
                            num = 2
                            roundcount = 1
                        }
                        c = Int.random(in: 0...num)
                        a = Int.random(in: 0...num)
                        answer = ""
                        
                    }
                }
            message:{
                Text(alertMessage)
            }
                
            
        
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                            b = 5
                            num = 2
                            roundcount = 1
                            
                        }) {
                            Label("Back", systemImage: "arrow.left.circle")
                            
                        }
                    }
                    ToolbarItem(placement: .keyboard) {
                            Button("Submit"){
                                if Int(answer) ?? 145 != a*c{
                                    alertText = ("Incorrect")
                                    alertMessage = ("Correct answer was \(a * c)")
                                    next = true
                                }
                                else{
                                    alertText = ("Correct")
                                    alertMessage = ("")
                                    next = true
                                }
                            }
                        }
                        
                        
                        
                        
                }
           
            }
        }
        

        
        
    





//DONE
struct Menu: View{
    
    let questNo = [5, 10, 20]
    @State private var tableSize = 2
    @State private var a = 5 //chosen option from array before
    var body: some View{
        NavigationStack{
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.primary)
                        .padding()
                        .opacity(0.10)
                        .frame(maxHeight: 450)
                    VStack{
                        Section{
                            Stepper("Max problem: \(tableSize) × \(tableSize)", value: $tableSize, in: 2...12)
                                .padding()
                            
                        }
                    header: {
                        Text("Choose your difficulty")
                            .font(.headline)
                    }
                    .padding()

                   
                        Section{
                            
                            Picker("", selection: $a) {
                                ForEach(questNo, id: \.self){
                                    Text(String($0))
                                }
                            }
                            .pickerStyle(.segmented)
                            .labelsHidden()
                            .padding()
                        }
                    header: {
                        Text("Number of questions")
                            .font(.headline)
                    }
                    .padding()
                    }
                }
                
                Spacer()
                Section{
                    Button {
                        
                    } label: {
                        NavigationLink(destination: ContentView(b: $a, num: $tableSize)) {
                            Image(systemName: "play.fill")
                                .imageScale(.large)
                                .padding()
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        
                    }
                }
                
            }
            .background(LinearGradient(colors: [.cyan, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        
        
    }
}
    

    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Menu()
        }
    }

