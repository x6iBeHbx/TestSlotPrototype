package reelEngine.command.game {
   import reelEngine.configs.ReelsEngineNotification;
   import reelEngine.configs.SlotConfiguration;
   import reelEngine.model.dto.ReelDto;
   import reelEngine.model.proxy.IconsProxy;
   import reelEngine.util.RandomIconGenerator;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   public class GenerateTopIconsCommand extends SimpleCommand {
      override public function execute(notification:INotification):void{

         var reelDto:ReelDto = notification.getBody() as ReelDto;
         var slotConfiguration:SlotConfiguration = new SlotConfiguration()
         generateIcons(reelDto, slotConfiguration);
         sendNotification(ReelsEngineNotification.INJECT_TOP_REEL_ICONS, reelDto);
      }

      private function generateIcons(reel:ReelDto, slotConfiguration:SlotConfiguration):void{

         for(var i:int = 0; i < reel.icons.length; i++){
            reel.topIcons[i].type = RandomIconGenerator.generateRandomIconId(slotConfiguration.iconsSet);
            reel.topIcons[i].icon = iconsProxy.getIconById(reel.topIcons[i].type);
            reel.topIcons[i].postionY = i * reel.topIcons[i].icon.height - (reel.topIcons[i].icon.height * reel.icons.length);
         }
      }

      private function get iconsProxy():IconsProxy{
         return facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
      }
   }
}


