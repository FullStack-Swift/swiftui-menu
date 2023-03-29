import SwiftUI
import Combine

public enum MenuType {
  case top
  case bottom
  case left
  case right
  case center
}

public struct MenuModifier<ContentModifier>: ViewModifier where ContentModifier: View {
  
  @Binding var isPresented: Bool
  let menuType: MenuType
  let contentModifier: () -> ContentModifier
  
  public init(
    isPresented: Binding<Bool>,
    menuType: MenuType,
    @ViewBuilder contentModifier: @escaping () -> ContentModifier
  ) {
    self._isPresented = isPresented
    self.menuType = menuType
    self.contentModifier = contentModifier
  }
  
  public func body(content: Content) -> some View {
    if #available(iOS 14.0, *) {
      ZStack {
        content
        switch menuType {
          case .left:
            LeftMenuView(isPresented: $isPresented, content: contentModifier())
          case .right:
            RightMenuView(isPresented: $isPresented, content: contentModifier())
          case .top:
            TopMenuView(isPresented: $isPresented, content: contentModifier())
          case .bottom:
            BottomMenuView(isPresented: $isPresented, content: contentModifier())
          case .center:
            CenterMenuView(isPresented: $isPresented, content: contentModifier())
        }
      }
      .onChange(of: isPresented) { newValue in
        if newValue == false {
          UIApplication.shared.endEditing()
        }
      }
    } else {
      // Fallback on earlier versions
      ZStack {
        content
        switch menuType {
          case .left:
            LeftMenuView(isPresented: $isPresented, content: contentModifier())
          case .right:
            RightMenuView(isPresented: $isPresented, content: contentModifier())
          case .top:
            TopMenuView(isPresented: $isPresented, content: contentModifier())
          case .bottom:
            BottomMenuView(isPresented: $isPresented, content: contentModifier())
          case .center:
            CenterMenuView(isPresented: $isPresented, content: contentModifier())
        }
      }
    }
  }
  
}

public struct CenterMenuView<Content>: View where Content: View {
  @Binding var isPresented: Bool
  let content: Content
  
  @State private var childSize: CGSize = .zero
  public var body: some View{
    ZStack {
      GeometryReader{ _ in
        EmptyView()
      }
      .background(Color.gray.opacity(0.7))
      .opacity(self.isPresented ? 1 : 0)
      .onTapGesture {
        withAnimation {
          isPresented = false
        }
      }
      content
        .hiddenTransitionScale(If: !isPresented)
    }
  }
}


public struct LeftMenuView<Content>: View where Content: View {
  @Binding var isPresented: Bool
  let content: Content
  
  @State private var childSize: CGSize = .zero
  public var body: some View{
    ZStack {
      GeometryReader{ _ in
        EmptyView()
      }
      .background(Color.gray.opacity(0.7))
      .opacity(self.isPresented ? 1 : 0)
      .onTapGesture {
        withAnimation {
          isPresented = false
        }
      }
      GeometryReader { geometry in
        HStack(spacing: 0) {
          ZStack {
            content
              .background(
                GeometryReader { proxy in
                  Color.clear
                    .preference(
                      key: SizePreferenceKey.self,
                      value: proxy.size
                    )
                }
              )
              .onPreferenceChange(SizePreferenceKey.self) { preferences in
                self.childSize = preferences
              }
          }
          Spacer(minLength: 0)
        }
      }
      .offset(x: self.isPresented ? 0 : -self.childSize.width - UIScreen.main.bounds.width)
    }
  }
}

public struct RightMenuView<Content>: View where Content: View {
  @Binding var isPresented: Bool
  let content: Content
  
  @State private var childSize: CGSize = .zero
  
  public var body: some View{
    ZStack {
      GeometryReader{ _ in
        EmptyView()
      }
      .background(Color.gray.opacity(0.7))
      .opacity(self.isPresented ? 1 : 0)
      .onTapGesture {
        withAnimation {
          isPresented = false
        }
      }
      GeometryReader { geometry in
        HStack {
          Spacer(minLength: 0)
          content
            .background(
              GeometryReader { proxy in
                Color.clear
                  .preference(
                    key: SizePreferenceKey.self,
                    value: proxy.size
                  )
              }
            )
            .onPreferenceChange(SizePreferenceKey.self) { preferences in
              self.childSize = preferences
            }
        }
      }
      .offset(x: self.isPresented ? 0 : childSize.width + UIScreen.main.bounds.width)
    }
  }
}

public struct TopMenuView<Content>: View where Content: View {
  @Binding var isPresented: Bool
  let content: Content
  
  @State private var childSize: CGSize = .zero
  public var body: some View{
    ZStack {
      GeometryReader{ _ in
        EmptyView()
      }
      .background(Color.gray.opacity(0.7))
      .opacity(self.isPresented ? 1 : 0)
      .onTapGesture {
        withAnimation {
          isPresented = false
        }
      }
      GeometryReader { geometry in
        VStack {
          content
            .background(
              GeometryReader { proxy in
                Color.clear
                  .preference(
                    key: SizePreferenceKey.self,
                    value: proxy.size
                  )
              }
            )
            .onPreferenceChange(SizePreferenceKey.self) { preferences in
              self.childSize = preferences
            }
          Spacer(minLength: 0)
        }
        
      }
      .offset(y: self.isPresented ? 0 : -childSize.height - UIScreen.main.bounds.height)
    }
  }
}

public struct BottomMenuView<Content>: View where Content: View {
  @Binding var isPresented: Bool
  let content: Content
  
  @State private var childSize: CGSize = .zero
  
  public var body: some View{
    ZStack {
      GeometryReader{ _ in
        EmptyView()
      }
      .background(Color.gray.opacity(0.7))
      .opacity(self.isPresented ? 1 : 0)
      .onTapGesture {
        withAnimation {
          isPresented = false
        }
      }
      GeometryReader { geometry in
        VStack {
          Spacer(minLength: 0)
          content
            .background(
              GeometryReader { proxy in
                Color.clear
                  .preference(
                    key: SizePreferenceKey.self,
                    value: proxy.size
                  )
              }
            )
            .onPreferenceChange(SizePreferenceKey.self) { preferences in
              self.childSize = preferences
            }
        }
      }
      .offset(y: self.isPresented ? 0 : childSize.height + UIScreen.main.bounds.height)
    }
  }
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero
  
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value = nextValue()
  }
}

extension Notification {
  var keyboardHeight: CGFloat {
    return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
  }
}

extension Publishers {
  static var keyboardHeight: AnyPublisher<CGFloat, Never> {
    let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
      .map { $0.keyboardHeight }
    let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
      .map { _ in CGFloat(0) }
    return MergeMany(willShow, willHide)
      .eraseToAnyPublisher()
  }
}

public struct KeyboardViewModifier: ViewModifier {
  @State private var keyboardHeight: CGFloat = 0
  
  public func body(content: Content) -> some View {
    content
      .padding(.bottom, keyboardHeight)
      .onReceive(Publishers.keyboardHeight) {
        self.keyboardHeight = $0
      }
  }
}

public extension View {
  func keyboardPadding() -> some View {
    ModifiedContent(content: self, modifier: KeyboardViewModifier())
  }
}

extension View {
  @ViewBuilder
  func hidden(If value: Bool, move: Edge) -> some View {
    if value {
      hidden()
        .transition(move: move)
    } else {
      self
        .transition(move: move)
    }
  }
  
  @ViewBuilder
  func hiddenTransitionScale(If value: Bool) -> some View {
    if value {
      hidden()
        .transitionScale()
    } else {
      self
        .transitionScale()
    }
  }
}

extension View {
  func transition(move: Edge) -> some View {
    transition(.asymmetric(insertion: .move(edge: move), removal: .move(edge: move)))
  }
  
  func transitionScale() -> some View {
    transition(.asymmetric(insertion: .scale.animation(.spring()), removal: .scale.animation(.spring())))
  }
}

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
