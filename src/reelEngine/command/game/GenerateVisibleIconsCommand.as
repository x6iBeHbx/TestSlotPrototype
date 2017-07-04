package reelEngine.command.game {
   import reelEngine.configs.ReelsEngineNotification;
   import reelEngine.configs.SlotConfiguration;
   import reelEngine.model.dto.ReelDto;
   import reelEngine.model.proxy.IconsProxy;
   import reelEngine.model.proxy.ReelsProxy;
   import reelEngine.util.RandomIconGenerator;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   public class GenerateVisibleIconsCommand extends SimpleCommand {
      override public function execute(notification:INotification):void{

         var reelDto:ReelDto = notification.getBody() as ReelDto;
         var slotConfiguration:SlotConfiguration = new SlotConfiguration()
         generateIcons(reelDto, slotConfiguration);
         sendNotification(ReelsEngineNotification.INJECT_VISIBLE_REEL_ICONS, reelDto);
      }

      private function generateIcons(reel:ReelDto, slotConfiguration:SlotConfiguration):void{

         for(var i:int = 0; i < reel.icons.length; i++){
            reel.icons[i].type = RandomIconGenerator.generateRandomIconId(slotConfiguration.iconsSet);
            reel.icons[i].icon = iconsProxy.getIconById(reel.icons[i].type);
            reel.icons[i].postionY = i * reel.icons[i].icon.height;
         }
      }

      private function get iconsProxy():IconsProxy{
         return facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
      }

      private function get reelsProxy():ReelsProxy {
         return facade.retrieveProxy(ReelsProxy.NAME) as ReelsProxy;
      }
   }
}


