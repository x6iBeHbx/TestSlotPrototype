package reelEngine.model.proxy {
   import core.utils.ResourceWarehouse;

   import flash.display.Bitmap;
   import flash.display.MovieClip;

   import reelEngine.configs.SlotConfiguration;
   import reelEngine.util.ArtParser;

   import org.puremvc.as3.patterns.proxy.Proxy;

   public class IconsProxy extends Proxy {

      private var _iconsBitmapSet:Vector.<Bitmap>;

      public static const NAME:String = "IconsProxy";
      public function IconsProxy(slotConfig:SlotConfiguration) {
         super(NAME);

         createIconsBitmapSet(slotConfig)
      }

      private function createIconsBitmapSet(slotConfig:SlotConfiguration):void{
         var iconsContainer:MovieClip = new (ResourceWarehouse.getInstance().getAssetClass("iconsContainer")) as MovieClip;
         _iconsBitmapSet = ArtParser.parseIconContainer(iconsContainer, slotConfig.iconsSet);
      }

      public function getIconById(id:int):Bitmap{

         var cloneIcon:Bitmap = new Bitmap();
         cloneIcon.bitmapData = _iconsBitmapSet[id].bitmapData.clone();

         return cloneIcon;
      }
   }
}


