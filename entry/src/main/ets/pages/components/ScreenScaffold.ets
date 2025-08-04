import TimeText from './TimeText'

@Component
export default struct ScreenScaffold {
  @BuilderParam content: () => void = this.defaultContent

  @Builder
  defaultContent() {
    Text("not implemented")
  }

  build() {
    Stack() {
      TimeText()
      this.content()
    }.width('100%')
    .height('100%')
  }
}

