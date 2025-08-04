import CurvedText from './CurvedText';

@Component
export default struct TeamNames {
  private fontSize: number = 32
  @State currentTime: string = "00:00"

  build() {
    Stack() {

      CurvedText({
        text: " Home",
        startAngle: Math.PI * 0.85,
        clockwise: false,
        fontSize: this.fontSize
      })

      CurvedText({
        text: "Visitor",
        startAngle: Math.PI * 0.3,
        clockwise: false,
        fontSize: this.fontSize
      })

    }.width('100%')
    .height('100%')
  }
}