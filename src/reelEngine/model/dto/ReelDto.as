package reelEngine.model.dto {
   import reelEngine.model.dto.IconDto;

   public class ReelDto {

      public var reelID:int;
      public var reelLength:int;
      public var icons:Vector.<IconDto>;
      public var topIcons:Vector.<IconDto>;

      public var isStoped:Boolean;
      public var needStop:Boolean;
      public var hasServerResponse:Boolean;
   }
}


