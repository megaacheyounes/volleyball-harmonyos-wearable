import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, LengthMetrics } from '@kit.ArkUI';
import ScreenScaffold from './components/ScreenScaffold';

interface MenuButton {
  title: string
  action: () => void
}

@Component
export default struct OptionsScreen {
  onChange?: () => void
  @Link scoreCount: number[][]
  @Link setCount: number[]
  @Link serving: boolean[]
  @Link matchPoint: boolean
  buttons: MenuButton[] = [{
    title: 'Undo',
    action: () => {
      this.undoLastScore()
    }
  }, {
    title: 'Reset score',
    action: () => {
      this.resetCurrentMatch()
    }
  }, {
    title: 'Reset ALL',
    action: () => {
      this.resetAll()
    }
  }]

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
    ArcList() {
      ForEach(this.buttons, (button: MenuButton) => {
        ArcListItem() {
          Button(button.title)
            .type(ButtonType.Capsule)
            .width('80%')
            .height(50)
            .backgroundColor($r("app.color.button"))
            .onClick(() => {
              button.action()
            })
        }
      }, (button: MenuButton) => button.title)
    }
    .width('100%')
    .height('100%')
    .space(LengthMetrics.px(10))
    .focusable(true)
    .defaultFocus(true)
    .focusOnTouch(true)
    .focusScopeId("1")
    .focusScopePriority("1", FocusPriority.PRIOR)

  }

  resetAll() {
    this.scoreCount = [[0, 0]];
    this.setCount = [0, 0];
    this.serving = [false, false];
    this.matchPoint = false;
    if (this.onChange) {
      this.onChange()
    }
  }

  resetCurrentMatch() {
    this.scoreCount = [[0, 0]];
    this.serving = [false, false];
    this.matchPoint = false;
    if (this.onChange) {
      this.onChange()
    }
  }

  undoLastScore() {
    if (this.scoreCount.length > 1) {
      this.scoreCount.pop();
      this.serving = [false, false];

      // Recalculate match point
      const current = this.scoreCount[this.scoreCount.length - 1];
      this.matchPoint = (current[0] >= 24 || current[1] >= 24) &&
        (current[0] !== current[1]);
    }
    if (this.onChange) {
      this.onChange()
    }

  }
}