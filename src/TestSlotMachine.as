package {
   import core.ApplicationFacade;
   import core.command.StarUpCommand;

   import flash.display.Sprite;
   import flash.events.Event;
import flash.system.Security;
import flash.system.SecurityDomain;

public class TestSlotMachine extends Sprite {

      public function TestSlotMachine() {

         this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
         //Security.allowDomain("*");
         //bad solution for little monitor =((
         this.scaleX = 0.8;
         this.scaleY = 0.8;
      }

      private function onAddedToStage(event:Event):void {
         this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
         ApplicationFacade.getInstance().startup(StarUpCommand, this);
      }
   }
}


