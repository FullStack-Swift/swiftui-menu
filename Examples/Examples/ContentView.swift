import SwiftUI
import SwiftUIMenu
import ButtonStyles
import SwiftUIViewModifier

struct ContentView: View {
  
  @State private var isPresentedTop: Bool = false
  @State private var isPresentedBottom: Bool = false
  @State private var isPresentedLeft: Bool = false
  @State private var isPresentedRight: Bool = false
  @State private var isPresentedCenter: Bool = false
  
  @State private var text: String = ""
  
  var body: some View {
    
    VStack {
      Spacer()
        .frame(height: 100)
      VStack(alignment: .center) {
        HStack(alignment: .center) {
          Button {
            withAnimation {
              self.isPresentedLeft = true
            }
          } label: {
            Text("Menu Left")
              .font(.callout)
              .fontWeight(.bold)
              .foregroundColor(.white)
          }
          .buttonStyle(BackgroundButtonStyle{
            Color.blue
              .clipShape(RoundedRectangle(cornerRadius: 8))
          })
          .padding()
          Button {
            withAnimation {
              self.isPresentedRight = true
            }
          } label: {
            Text("Menu Right")
              .font(.callout)
              .fontWeight(.bold)
              .foregroundColor(.white)
          }
          .buttonStyle(BackgroundButtonStyle{
            Color.green
              .clipShape(RoundedRectangle(cornerRadius: 8))
          })
          .padding()
        }
        
        HStack {
          Button {
            withAnimation {
              self.isPresentedCenter = true
            }
          } label: {
            Text("Menu Center")
              .font(.callout)
              .fontWeight(.bold)
              .foregroundColor(.white)
          }
          .buttonStyle(BackgroundButtonStyle{
            Color.purple
              .clipShape(RoundedRectangle(cornerRadius: 8))
          })
          .padding()
        }
        
        HStack(alignment: .center) {
          Button {
            withAnimation {
              self.isPresentedTop = true
            }
          } label: {
            Text("Menu Top")
              .font(.callout)
              .fontWeight(.bold)
              .foregroundColor(.white)
          }
          .buttonStyle(BackgroundButtonStyle{
            Color.orange
              .clipShape(RoundedRectangle(cornerRadius: 8))
          })
          .padding()
          Button {
            withAnimation {
              self.isPresentedBottom = true
            }
          } label: {
            Text("Menu Bottom")
              .font(.callout)
              .fontWeight(.bold)
              .foregroundColor(.white)
          }
          .buttonStyle(BackgroundButtonStyle{
            Color.red
              .clipShape(RoundedRectangle(cornerRadius: 8))
          })
          .padding()
        }
      }
    }
    .modifier(
      MenuModifier(
        isPresented: $isPresentedLeft,
        menuType: .left,
        contentModifier: {
          List {
            ForEach(1..<1000) { item in
              HStack {
                Text(String(item) + UUID().uuidString)
                Spacer()
              }
              .frame(maxWidth: .infinity)
              .clipShape(Rectangle())
              .onTapGesture {
                withAnimation {
                  isPresentedLeft = false
                }
              }
            }
          }
          .listStyle(.plain)
          .frame(width: 300)
        }
      )
    )
    .modifier(
      MenuModifier(
        isPresented: $isPresentedRight,
        menuType: .right,
        contentModifier: {
          List {
            ForEach(1..<1000) { item in
              HStack {
                Text(String(item) + UUID().uuidString)
                Spacer()
              }
              .frame(maxWidth: .infinity)
              .clipShape(Rectangle())
              .onTapGesture {
                withAnimation {
                  isPresentedRight = false
                }
              }
            }
          }
          .listStyle(.plain)
          .frame(width: 300)
        }
      )
    )
    .modifier(
      MenuModifier(
        isPresented: $isPresentedTop,
        menuType: .top,
        contentModifier: {
          VStack {
            DatePicker("", selection: .constant(Date()))
              .datePickerStyle(.graphical)
              .padding(.zero)
          }
          .background(Color(.systemBackground))
        }
      )
    )
    .modifier(
      MenuModifier(
        isPresented: $isPresentedBottom,
        menuType: .bottom,
        contentModifier: {
          VStack(spacing: 0) {
            TopBottomBarView(
              background: LinearGradient(
                colors: [.red, .orange, .green],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
            Group {
              HStack {
                Image(systemName: "sun.max.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 24, height: 24, alignment: .center)
                  .foregroundColor(Color.orange)
                TextField("Email", text: $text)
                  .foregroundColor(.orange)
                  .font(.body)
                  .fontWeight(.thin)
              }
              .frame(height: 44)
              Divider()
              HStack {
                Image(systemName: "star.slash.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 24, height: 24, alignment: .center)
                  .foregroundColor(Color.orange)
                TextField("Password", text: $text)
                  .foregroundColor(.orange)
                  .font(.body)
                  .fontWeight(.thin)
              }
              .frame(height: 44)
              Divider()
              HStack {
                Button {
                  withAnimation {
                  }
                } label: {
                  Text("OK")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                }
                .buttonStyle(BackgroundButtonStyle{
                  Color.orange
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                })
                
                Button {
                  withAnimation {
                  }
                } label: {
                  Text("Cancel")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                }
                .buttonStyle(BackgroundButtonStyle{
                  Color.orange
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                })
              }
              .frame(height: 44)
              .padding(.vertical, 24)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color(.systemBackground))
          }
        }
      )
    )
    .modifier(MenuModifier(isPresented: $isPresentedCenter, menuType: .center, contentModifier: {
      VStack(spacing: 0) {
        TopBottomBarView(
          background: LinearGradient(
            colors: [.red, .orange, .green],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        Group {
          HStack {
            Image(systemName: "sun.max.fill")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 24, height: 24, alignment: .center)
              .foregroundColor(Color.orange)
            TextField("Email", text: $text)
              .foregroundColor(.orange)
              .font(.body)
              .fontWeight(.thin)
          }
          .frame(height: 44)
          Divider()
          HStack {
            Image(systemName: "star.slash.fill")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 24, height: 24, alignment: .center)
              .foregroundColor(Color.orange)
            TextField("Password", text: $text)
              .foregroundColor(.orange)
              .font(.body)
              .fontWeight(.thin)
          }
          .frame(height: 44)
          Divider()
          HStack {
            Button {
              withAnimation {
                isPresentedCenter = false
              }
            } label: {
              Text("OK")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
            .buttonStyle(BackgroundButtonStyle{
              Color.orange
                .clipShape(RoundedRectangle(cornerRadius: 8))
            })
            
            Button {
              withAnimation {
                isPresentedCenter = false
              }
            } label: {
              Text("Cancel")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
            .buttonStyle(BackgroundButtonStyle{
              Color.orange
                .clipShape(RoundedRectangle(cornerRadius: 8))
            })
          }
          .frame(height: 44)
          .padding(.vertical, 24)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(Color(.systemBackground))
      }
      .frame(width: 333, height: 333, alignment: .center)
    }))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

public struct TopBottomBarView<Background>: View where Background: View {
  
  var background: Background
  
  public var body: some View {
    ZStack {
      ZStack {
        background
          .clipShape(TopBottomBarShape())
        TopBottomBarShape()
          .foregroundColor(Color.clear)
      }
      
      VStack(spacing: 0) {
        Spacer()
          .frame(height: 12)
        Capsule()
          .frame(width: 30, height: 7)
          .foregroundColor(Color.white)
      }
    }
    .frame(maxWidth: .infinity)
    .frame(height: 44)
  }
}

struct TopBottomBarShape: Shape {
  
  private var radius: CGFloat?
  
  init(radius: CGFloat? = nil) {
    self.radius = radius
  }
  
  func path(in rect: CGRect) -> Path {
    let radius = radius ?? rect.height/2
    var path = Path()
    path.move(to: CGPoint(x: 0, y: rect.height))
    path.addArc(center: CGPoint(x: radius, y: radius),
                radius: radius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false)
    path.addLine(to: CGPoint(x: rect.width - rect.height, y: 0))
    path.addArc(center: CGPoint(x: rect.width - radius, y: radius),
                radius: radius,
                startAngle: .degrees(270),
                endAngle: .degrees(360),
                clockwise: false)
    path.addLine(to: CGPoint(x: rect.width, y: rect.height))
    path.addLine(to: CGPoint(x: 0, y: rect.height))
    return path
  }
}
