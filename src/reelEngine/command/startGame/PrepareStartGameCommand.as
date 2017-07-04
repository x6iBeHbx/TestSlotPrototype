package reelEngine.command.startGame {
   import controlPanel.config.ControlPanelNotification;
   import controlPanel.model.proxy.ControlPanelProxy;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   import reelEngine.configs.ReelsEngineNotification;
   import reelEngine.configs.SlotConfiguration;
   import reelEngine.model.dto.IconDto;
   import reelEngine.model.dto.ReelDto;
   import reelEngine.model.proxy.ReelsProxy;
   import reelEngine.model.proxy.spin.SpinProxy;

   public class PrepareStartGameCommand extends SimpleCommand {
      override public function execute(notification:INotification):void {

         var slotConfiguration:SlotConfiguration = new SlotConfiguration();
         var reelsCount:int = slotConfiguration.slotMatrix.length;

         reelsProxy.reelsDto.reelsCount = reelsCount;
         reelsProxy.reelsDto.reels = createReelsDto(slotConfiguration.slotMatrix);

         for(var i:int = 0; i < reelsProxy.reelsDto.reels.length; i++){
            sendNotification(ReelsEngineNotification.GENERATE_VISIBLE_ICONS, reelsProxy.reelsDto.reels[i]);
            sendNotification(ReelsEngineNotification.GENERATE_TOP_ICONS, reelsProxy.reelsDto.reels[i]);
         }


         reelRender.reelsDto = reelsProxy.reelsDto;
         reelRender.speedForSpin = slotConfiguration.spinSpeed;

         controlPanelProxy.userBalance = slotConfiguration.balanceForStartGame;
         controlPanelProxy.userBet = slotConfiguration.spinBet;

         sendNotification(ControlPanelNotification.UPDATE_SPIN_BET, controlPanelProxy.userBet);
         sendNotification(ControlPanelNotification.UPDATE_USER_BALANCE, controlPanelProxy.userBalance);
      }


      private function createReelsDto(matrix:Array):Vector.<ReelDto>{

         var reels:Vector.<ReelDto> = new <ReelDto>[];

         for(var i:int = 0; i < matrix.length; i++){
            var reelDto:ReelDto = new ReelDto();

            reelDto.reelID = i;
            reelDto.icons = createIconsDto(matrix[i]);
            reelDto.topIcons = createIconsDto(matrix[i]);
            reelDto.reelLength = reelDto.icons.length;
            reels.push(reelDto);
         }

         return reels;
      }

      private function createIconsDto(reel:Array):Vector.<IconDto>{
         var icons:Vector.<IconDto> = new <IconDto>[];
         for(var i:int = 0; i < reel.length; i++){
            var iconDto:IconDto = new IconDto();
            iconDto.id = i;
            icons.push(iconDto);
         }

         return icons;
      }

      private function get controlPanelProxy():ControlPanelProxy {
         return facade.retrieveProxy(ControlPanelProxy.NAME) as ControlPanelProxy;
      }

      private function get reelsProxy():ReelsProxy {
         return facade.retrieveProxy(ReelsProxy.NAME) as ReelsProxy;
      }

      private function get reelRender():SpinProxy {
         return facade.retrieveProxy(SpinProxy.NAME) as SpinProxy;
      }
   }
}


