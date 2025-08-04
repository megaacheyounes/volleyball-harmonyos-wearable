@Component
export default struct ServingIcon {
  build() {
    Image($r('app.media.volleyball_white'))
      .height(20)
      .width(20)
      .fillColor($r("app.color.volleyball_color"))
  }
}