@Component
export default struct CurvedText {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private radius: number = 105
  private canvasWidth: number = 466
  private canvasHeight: number = 466
  private centerX: number = 233
  private centerY: number = 233
  // props
  @Prop @Watch("drawCurvedText") text: string
  @Prop fontSize?: number = 35
  @Prop startAngle: number
  @Prop clockwise: boolean

  build() {
    Canvas(this.context)
      .width(this.canvasWidth)
      .height(this.canvasHeight)
      .onReady(() => {
        this.drawCurvedText()
      })
  }

  private drawCurvedText() {
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
    // Draw current time
    this.drawTextAlongArc(this.text, this.startAngle, this.radius, this.clockwise)
  }

  private drawTextAlongArc(text: string, startAngle: number, radius: number, clockwise: boolean) {
    this.context.save()

    // Set text properties
    this.context.fillStyle = '#FFFFFF'
    this.context.font = this.fontSize + 'px sans-serif bold'
    this.context.textAlign = 'center'
    this.context.textBaseline = 'middle'

    const textLength = text.length
    const angleStep = (Math.PI * 0.16) / (textLength - 1)

    for (let i = 0; i < textLength; i++) {
      const char = text[i]
      const angle = clockwise ?
        startAngle + (i * angleStep) :
        startAngle - (i * angleStep)

      // Calculate position for each character
      const x: number = this.centerX + Math.cos(angle) * radius
      const y: number = this.centerY + Math.sin(angle) * radius

      this.context.save()
      this.context.translate(x, y)

      // Rotate character to follow the curve
      const rotationAngle = clockwise ? angle + Math.PI / 2 : angle - Math.PI / 2
      this.context.rotate(rotationAngle)

      this.context.fillText(char, 0, 0)
      this.context.restore()
    }

    this.context.restore()
  }
}