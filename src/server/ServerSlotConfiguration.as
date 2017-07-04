package server {
   public class ServerSlotConfiguration {

      public var slotMatrix:Array = [[0,0,0], [0,0,0], [0,0,0], [0,0,0], [0,0,0]];
      public var winLinesMatrix:Array = [[0,0,0,0,0], [1,1,1,1,1], [2,2,2,2,2]];
      public var iconsSet:Array = [0,1,2,3,4,5];
      public var iconsWinSum:Array = [10,20,30,50,100,200];
      public var minIconsForWinPerLine:int = 3;
      public var multipliers:Array = [1,3,5];
   }
}


