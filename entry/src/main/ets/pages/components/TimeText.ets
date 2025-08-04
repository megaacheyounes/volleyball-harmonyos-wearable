import CurvedText from './CurvedText';

@Component
export default struct TimeText {
  @State currentTime: string = "00:00"
  private timerId: number = -1

  private updateTime() {
    const now = new Date();
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');
    this.currentTime = `${hours}:${minutes}`;
  }

  private scheduleNextUpdate() {
    const now = new Date();
    // Calculate milliseconds until the next minute (when seconds = 0)
    const millisecondsUntilNextMinute = (60 - now.getSeconds()) * 1000 - now.getMilliseconds();

    this.timerId = setTimeout(() => {
      this.updateTime();
      // After the first update, set up regular interval every 60 seconds
      this.timerId = setInterval(() => {
        this.updateTime();
      }, 60000); // Update every minute
    }, millisecondsUntilNextMinute);
  }

  aboutToAppear(): void {
    this.updateTime();
    this.scheduleNextUpdate();
  }

  aboutToDisappear(): void {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  build() {
    CurvedText({
      text: this.currentTime,
      fontSize: 30,
      startAngle: Math.PI * 1.42,
      clockwise: true
    })
  }
}