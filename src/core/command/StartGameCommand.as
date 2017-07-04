package core.command {
   import animation.view.component.WinLineAnimViewLogic;
   import animation.view.mediator.WinLineAnimMediator;

   import cheats.command.TurnOffCheatsCommand;
   import cheats.command.TurnOnCheatsCommand;
   import cheats.config.CheatNotification;
   import cheats.model.proxy.CheatProxy;
   import cheats.view.component.CheatPanelViewLogic;
   import cheats.view.mediator.CheatMediator;

   import controlPanel.model.proxy.ControlPanelProxy;

   import controlPanel.view.component.ControlPanelViewLogic;
   import controlPanel.view.mediator.ControlPanelMediator;

   import core.model.proxy.ServerCaller;

   import core.utils.ResourceWarehouse;
   import core.view.mediator.RootMediator;

   import flash.display.MovieClip;

   import reelEngine.command.StartSpinCommand;
   import reelEngine.command.game.AllReelsStopCommand;

   import reelEngine.command.game.GenerateTopIconsCommand;
   import reelEngine.command.game.GenerateVisibleIconsCommand;
   import reelEngine.command.game.SetServerResponseCommand;
   import reelEngine.command.game.StopSpinCommand;
   import reelEngine.command.startGame.PrepareStartGameCommand;
   import reelEngine.configs.ReelsEngineNotification;
   import reelEngine.configs.SlotConfiguration;
   import reelEngine.model.dto.response.ResponseDto;
   import reelEngine.model.proxy.response.ResponseProxy;
   import reelEngine.model.proxy.spin.SpinProxy;
   import reelEngine.model.dto.ReelsDto;
   import reelEngine.model.proxy.IconsProxy;
   import reelEngine.model.proxy.ReelsProxy;
   import reelEngine.view.component.ReelsViewLogic;
   import reelEngine.view.mediator.ReelsMediator;

   import org.puremvc.as3.interfaces.INotification;
   import org.puremvc.as3.patterns.command.SimpleCommand;

   public class StartGameCommand extends SimpleCommand {

      override public function execute(notification:INotification):void {

         registerProxy();
         registerGameCommand();
         registerMediators();
         sendNotification(ReelsEngineNotification.PREPARE_START_GAME);
      }

      private function registerProxy():void{
         var mainScene:MovieClip = ResourceWarehouse.getInstance().getAsset("slot_content") as MovieClip;

         facade.registerProxy(new SpinProxy(mainScene));
         facade.registerProxy(new IconsProxy(new SlotConfiguration()))
         facade.registerProxy(new ReelsProxy(new ReelsDto()));
         facade.registerProxy(new CheatProxy());
         facade.registerProxy(new ServerCaller());
         facade.registerProxy(new ResponseProxy(new ResponseDto()));
         facade.registerProxy(new ControlPanelProxy());
      }

      private function registerMediators():void{
         facade.registerMediator(new ReelsMediator(new ReelsViewLogic("slot_content")));
         facade.registerMediator(new ControlPanelMediator(new ControlPanelViewLogic("slot_content")));
         facade.registerMediator(new CheatMediator(new CheatPanelViewLogic("slot_content")));
         facade.registerMediator(new WinLineAnimMediator(new WinLineAnimViewLogic("slot_content")));
      }

      private function registerGameCommand():void {
         facade.registerCommand(ReelsEngineNotification.PREPARE_START_GAME, PrepareStartGameCommand);
         facade.registerCommand(ReelsEngineNotification.GENERATE_VISIBLE_ICONS, GenerateVisibleIconsCommand);
         facade.registerCommand(ReelsEngineNotification.GENERATE_TOP_ICONS, GenerateTopIconsCommand);
         facade.registerCommand(ReelsEngineNotification.SET_SERVER_RESPONSE, SetServerResponseCommand);

         facade.registerCommand(CheatNotification.TURN_ON_CHEATS, TurnOnCheatsCommand);
         facade.registerCommand(CheatNotification.TURN_OFF_CHEATS, TurnOffCheatsCommand);

         facade.registerCommand(ReelsEngineNotification.START_SPIN, StartSpinCommand);
         facade.registerCommand(ReelsEngineNotification.STOP_SPIN, StopSpinCommand);
         facade.registerCommand(ReelsEngineNotification.ALL_REELS_STOP, AllReelsStopCommand);
      }
   }
}


