package reelEngine.util {
   public class RandomIconGenerator {

      public static function generateRandomIconId(iconsSet:Array):int {
         return Math.floor(Math.random() * iconsSet.length);
      }
   }
}


