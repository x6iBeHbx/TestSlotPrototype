package reelEngine.util {
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;

   public class ArtParser {

      public static function parseIconContainer(iconContainer:MovieClip, iconsId:Array):Vector.<Bitmap> {

         var mcSet:Vector.<Bitmap> = new <Bitmap>[];
         for(var i:int = 0; i < iconsId.length; i++){
            iconContainer.gotoAndStop(iconsId[i] + 1);
            mcSet.push(generateBitmap(iconContainer))
         }

         return mcSet;
      }

      public static function generateBitmap(icon:MovieClip):Bitmap {

         var bmd:BitmapData=new BitmapData(icon.width, icon.height,false);
         bmd.draw(icon);

         var btm:Bitmap = new Bitmap();
         btm.bitmapData = bmd
         btm.smoothing = true;
         return btm;
      }
   }
}


