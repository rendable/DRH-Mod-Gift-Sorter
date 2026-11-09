package mods.gift_sorter;

import mods.api.Context;
import mods.api.Mod;
import account.DBAccountInfo;
import collections.Map;

class Main extends Mod {
    var account:DBAccountInfo;
    var original:Map;
    var sorted:SortedGiftMap;
    var context:Context;

    override public function ready(context:Context):Void {
        this.context = context;
        account = context.core.facade.dbAccountInfo;
        original = account.gifts;
        if (original == null) throw "Account gift collection is unavailable";
        sorted = new SortedGiftMap(context.core.facade, original);
        // Only this account's gift collection uses the sorted subclass.
        Reflect.setField(account, "mGiftsInfo", sorted);
        if (account.gifts != sorted) throw "Could not attach the gift sorter";
        context.log("loaded: health shot, mana shot, health bomb, then alphabetical");
    }

    override public function dispose():Void {
        if (account != null && sorted != null && account.gifts == sorted) {
            // Preserve additions, removals and clear operations performed during play.
            original._stringMap = sorted._stringMap;
            original._keys = sorted._keys;
            original._items = sorted._items;
            original._size = sorted._size;
            Reflect.setField(account, "mGiftsInfo", original);
        }
        sorted = null;
        original = null;
        account = null;
    }
}
