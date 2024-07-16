// ./tabs/TabItems.ets

@Component
export struct Tab {
  @Prop isSelected: boolean = false;
  @State tabItemData: TabItemData = new TabItemData(0, undefined!, [], [])

  build() {
    Flex({
      direction: FlexDirection.Column,
      alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.Center
    }) {
      Image(this.isSelected ? this.tabItemData.icon[0] : this.tabItemData.icon[1])
        .objectFit(ImageFit.Contain)
        .width(24)
        .height(24)
      Text(this.tabItemData.name)
        .fontColor(this.isSelected ? this.tabItemData.color[0] : this.tabItemData.color[1])
        .fontSize(10)
        .height(14)
        .textAlign(TextAlign.Center)
        .margin({top: 4})
    }.width('100%').height('100%')
  }
}


export class TabItemData {
  index: number = 0;
  name: Resource;
  icon: Array<Resource> = [];
  color: Array<Resource> = [];

  constructor(index: number, name: Resource,
    icon: Array<Resource>, color: Array<Resource>) {
    this.index = index;
    this.name = name;
    this.icon = icon;
    this.color = color;
  }
}


// ./MainPage.ets
import { Home } from '@genius/feature_home'
import { My } from '@genius/feature_my'
import { Tab, TabItemData } from './tabs/TabItem'

@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0

  private tabItems: TabItemData[] = [
    new TabItemData(0, $r('app.string.home'),
      [$r('app.media.table_click_home'), $r('app.media.table_unclick_home')],
      [$r('app.color.tab_text_on'), $r('app.color.tab_text_off')]),
    new TabItemData(1, $r('app.string.my'),
      [$r('app.media.table_click_mine'), $r('app.media.table_unclick_mine')],
      [$r('app.color.tab_text_on'), $r('app.color.tab_text_off')])]

  build() {
    Navigation() {
      Tabs({ barPosition: BarPosition.End}) {
        TabContent() {
          Home()
        }
        .tabBar(this.tabBuilder(this.tabItems[0]))

        TabContent() {
          My()
        }
        .tabBar(this.tabBuilder(this.tabItems[1]))
      }
      .onTabBarClick((index: number) => {
        this.currentIndex = index
      })
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
  }

  @Builder
  tabBuilder(item: TabItemData) {
    Tab({
      tabItemData: item,
      isSelected: item.index === this.currentIndex,
    })
  }
}




