import { ArcDotIndicator, ArcSwiper, ArcSwiperAttribute, ArcSwiperController } from '@kit.ArkUI';
import MainScreen from './MainScreen';
import OptionsScreen from './OptionsScreen';

@Entry
@Component
struct Index {
  @State scoreCount: number[][] = [[0, 0]];
  @State setCount: number[] = [0, 0];
  @State serving: boolean[] = [false, false];
  @State matchPoint: boolean = false;
  @State currentPage: number = 0;
  private swiperController: ArcSwiperController = new ArcSwiperController();
  private arcDotIndicator: ArcDotIndicator = new ArcDotIndicator();

  build() {
    Stack() {

      ArcSwiper(this.swiperController) {
        MainScreen({
          scoreCount: this.scoreCount,
          setCount: this.setCount,
          serving: this.serving,
          matchPoint: this.matchPoint
        })
        OptionsScreen({
          scoreCount: this.scoreCount,
          setCount: this.setCount,
          serving: this.serving,
          matchPoint: this.matchPoint,
          onChange: () => {
            console.log("on settings change")
            //show main screen
            this.swiperController.showPrevious()
          }
        })
      }
      .width("100%")
      .height('100%')
      .effectMode(EdgeEffect.Spring)
      .indicator(this.arcDotIndicator)
      .digitalCrownSensitivity(CrownSensitivity.MEDIUM)
      .linearGradient({ colors: [[$r('app.color.background_gradient_start'), 0], [Color.Black, 1]] })
      .focusable(true)
      .defaultFocus(true)
      .focusScopeId("1")
      .focusScopePriority("1", FocusPriority.PREVIOUS)


    }.height('100%')
    .width("100%")
    .alignContent(Alignment.Center)
  }
}
