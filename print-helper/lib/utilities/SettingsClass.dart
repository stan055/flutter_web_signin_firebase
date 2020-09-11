class SettingsCanvas{
    bool FLIP_ITEM;
    bool SORT_LARGEST;
    bool LEFT_HORIZONTAL;
    bool LEFT_TOP;
    bool RIGHT_HORIZONTAL;
    bool RIGHT_TOP;
    bool START_WIDTH_HEIGHT;
    bool INCREMENT_PROGRESSIVE_HEIGHT_WIDTH;
    bool FLIP_LIST_TO_HEIGHT;
    bool FLIP_LIST_TO_WIDTH;
    bool CREATE_AREA_LIST;
    bool SORT_INDEX;
    bool SIMPLE_LINE_LAYOUT;
    bool AUTO_SETTINGS;

    SettingsCanvas({
      this.FLIP_ITEM,
      this.SORT_LARGEST,
      this.LEFT_HORIZONTAL,
      this.LEFT_TOP,
      this.RIGHT_HORIZONTAL,
      this.RIGHT_TOP,
      this.START_WIDTH_HEIGHT,
      this.INCREMENT_PROGRESSIVE_HEIGHT_WIDTH,
      this.FLIP_LIST_TO_HEIGHT,
      this.FLIP_LIST_TO_WIDTH,
      this.CREATE_AREA_LIST,
      this.SORT_INDEX,
      this.SIMPLE_LINE_LAYOUT,
      this.AUTO_SETTINGS,
    });
}

List<SettingsCanvas> settingsCanvasList = [
  // 0
  SettingsCanvas(    
    FLIP_ITEM: true,
    SORT_LARGEST: false,
    LEFT_HORIZONTAL: false,
    LEFT_TOP: false,
    RIGHT_HORIZONTAL: false,
    RIGHT_TOP: false,
    START_WIDTH_HEIGHT: true,
    INCREMENT_PROGRESSIVE_HEIGHT_WIDTH: true,
    FLIP_LIST_TO_HEIGHT: false,
    FLIP_LIST_TO_WIDTH: false,
    CREATE_AREA_LIST: false,
    SORT_INDEX: false,
    SIMPLE_LINE_LAYOUT: false,
    AUTO_SETTINGS: true,
    ),
  // 1
  SettingsCanvas(    
    FLIP_ITEM: true,
    SORT_LARGEST: false,
    LEFT_HORIZONTAL: false,
    LEFT_TOP: false,
    RIGHT_HORIZONTAL: false,
    RIGHT_TOP: false,
    START_WIDTH_HEIGHT: false,
    INCREMENT_PROGRESSIVE_HEIGHT_WIDTH: false,
    FLIP_LIST_TO_HEIGHT: false,
    FLIP_LIST_TO_WIDTH: false,
    CREATE_AREA_LIST: false,
    SORT_INDEX: false,
    SIMPLE_LINE_LAYOUT: false,
    AUTO_SETTINGS: true,
    ),
  // 2
      SettingsCanvas(    
    FLIP_ITEM: true,
    SORT_LARGEST: true,
    LEFT_HORIZONTAL: false,
    LEFT_TOP: false,
    RIGHT_HORIZONTAL: false,
    RIGHT_TOP: false,
    START_WIDTH_HEIGHT: true,
    INCREMENT_PROGRESSIVE_HEIGHT_WIDTH: true,
    FLIP_LIST_TO_HEIGHT: false,
    FLIP_LIST_TO_WIDTH: true,
    CREATE_AREA_LIST: false,
    SORT_INDEX: true,
    SIMPLE_LINE_LAYOUT: true,
    AUTO_SETTINGS: true,
    ),


// 3
              SettingsCanvas(    
    FLIP_ITEM: true,
    SORT_LARGEST: true,
    LEFT_HORIZONTAL: false,
    LEFT_TOP: false,
    RIGHT_HORIZONTAL: false,
    RIGHT_TOP: false,
    START_WIDTH_HEIGHT: true,
    INCREMENT_PROGRESSIVE_HEIGHT_WIDTH: true,
    FLIP_LIST_TO_HEIGHT: false,
    FLIP_LIST_TO_WIDTH: true,
    CREATE_AREA_LIST: false,
    SORT_INDEX: false,
    SIMPLE_LINE_LAYOUT: false,
    AUTO_SETTINGS: true,
    ),

// 4
          SettingsCanvas(    
    FLIP_ITEM: true,
    SORT_LARGEST: true,
    LEFT_HORIZONTAL: false,
    LEFT_TOP: false,
    RIGHT_HORIZONTAL: false,
    RIGHT_TOP: true,
    START_WIDTH_HEIGHT: true,
    INCREMENT_PROGRESSIVE_HEIGHT_WIDTH: false,
    FLIP_LIST_TO_HEIGHT: true,
    FLIP_LIST_TO_WIDTH: false,
    CREATE_AREA_LIST: false,
    SORT_INDEX: true,
    SIMPLE_LINE_LAYOUT: false,
    AUTO_SETTINGS: true,
    ),


];