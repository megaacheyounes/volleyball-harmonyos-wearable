import ScoreCounter from './components/ScoreCounter'
import TeamNames from './components/TeamNames'
import ServingIcon from './components/ServingIcon'
import { vibrator } from '@kit.SensorServiceKit'
import ScreenScaffold from './components/ScreenScaffold'

@Component
export default struct MainScreen {
  @Link scoreCount: number[][]
  @Link setCount: number[]
  @Link serving: boolean[]
  @Link matchPoint: boolean

  build() {
    Stack() {
      ScreenScaffold({
        content: () => {
          this.mainContent()
        }
      })

    }.height("100%")
    .width("100%")
  }

  @Builder
  mainContent() {
    this.scoreView()
    TeamNames()
    this.teamButtons()
  }

  @Builder
  scoreView() {
    Column() {
      Text('Match Point! 🏆')
        .fontSize(18)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 10 })
        .visibility(this.matchPoint ? Visibility.Visible : Visibility.Hidden)

      ScoreCounter({ scoreCount: this.scoreCount })

      Row() {
        // Team 1 serving indicator
        ServingIcon()
          .visibility(this.serving[0] ? Visibility.Visible : Visibility.Hidden)

        // Set scores
        Row() {
          Text(this.setCount[0].toString())
            .fontSize(25)
            .fontColor(Color.White)
            .width('30%')
            .textAlign(TextAlign.End)

          Text(' - ')
            .fontSize(25)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)

          Text(this.setCount[1].toString())
            .fontSize(25)
            .fontColor(Color.White)
            .width('30%')
            .textAlign(TextAlign.Start)
        }
        .width(80)

        // Team 2 serving indicator
        ServingIcon()
          .visibility(this.serving[1] ? Visibility.Visible : Visibility.Hidden)

      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  teamButtons() {
    // Team buttons (invisible but clickable)
    Row() {
      Button('')
        .backgroundColor(Color.Transparent)
        .type(ButtonType.Normal)
        .width('50%')
        .height('100%')
        .onClick(() => {
          this.updateScore(0);
        })

      Button('')
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width('50%')
        .height('100%')
        .onClick(() => {
          this.updateScore(1);
        })

    }
    .width('100%')
    .height("100%")
    .justifyContent(FlexAlign.SpaceBetween)
  }

  updateScore(teamIndex: number) {
    vibrator.startVibration({ type: 'time', duration: 50 }, { usage: "touch" })


    const otherTeam = teamIndex ^ 1;
    let currentScore = [...this.scoreCount[this.scoreCount.length - 1]];

    currentScore[teamIndex]++;
    this.serving[teamIndex] = true;
    this.serving[otherTeam] = false;

    // Check if set is won
    if (currentScore[teamIndex] >= 25 &&
      (currentScore[teamIndex] - currentScore[otherTeam] >= 2)) {
      // Set won
      currentScore = [0, 0];
      this.scoreCount = [[0, 0]];
      this.setCount[teamIndex]++;
      this.serving = [false, false];
      this.matchPoint = false;
    } else {
      // Update score history
      this.scoreCount.push(currentScore);

      // Check for match point
      this.matchPoint = (currentScore[teamIndex] >= 24 || currentScore[otherTeam] >= 24) &&
        (currentScore[teamIndex] !== currentScore[otherTeam]);
    }
    if (this.matchPoint) {
      vibrator.startVibration({ type: 'time', duration: 250 }, { usage: "touch" })
    }

  }
}