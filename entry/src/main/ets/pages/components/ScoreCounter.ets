@Component
export default struct ScoreCounter {
  private scoreFontSize = 55
  @Link scoreCount: number[][]

  build() {
    Row() {
      Text(this.scoreCount[this.scoreCount.length - 1][0].toString())
        .fontSize(this.scoreFontSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width('30%')
        .textAlign(TextAlign.End)

      Text(' - ')
        .fontSize(this.scoreFontSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)

      Text(this.scoreCount[this.scoreCount.length - 1][1].toString())
        .fontSize(this.scoreFontSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width('30%')
        .textAlign(TextAlign.Start)
    }
    .justifyContent(FlexAlign.Center)

  }
}