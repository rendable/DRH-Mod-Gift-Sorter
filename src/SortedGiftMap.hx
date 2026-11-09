package mods.gift_sorter;

import account.GiftInfo;
import collections.Map;
import facade.DBFacade;
import facade.Locale;
import gameMasterDictionary.GMOffer;

/** The native popup keeps its original rendering, controls, and geometry. */
class SortedGiftMap extends Map {
    var facade:DBFacade;

    public function new(facade:DBFacade, source:Map) {
        super();
        this.facade = facade;
        // Share the original entries and preserve every gift's identity.
        _stringMap = source._stringMap;
        _keys = source._keys;
        _items = source._items;
        _size = source._size;
    }

    override public function keysToArray():Array<Dynamic> {
        var keys = super.keysToArray();
        // Resolve names once per gift, rather than once per comparison.
        var rows:Array<Dynamic> = [];
        for (index in 0...keys.length) {
            var key = keys[index];
            var gift:GiftInfo = cast itemFor(key);
            var name = "";
            if (gift != null) {
                var offer:GMOffer = cast facade.gameMaster.offerById.itemFor(gift.offerId);
                if (offer != null) {
                    var displayName = offer.getDisplayName(facade.gameMaster, Locale.getString("GIFT_UNKNOWN_NAME"));
                    if (displayName != null) name = displayName.toLowerCase();
                }
            }
            rows.push({key: key, name: name, weight: priority(name), index: index});
        }
        rows.sort(function(a:Dynamic, b:Dynamic):Int {
            if (a.weight < b.weight) return -1;
            if (a.weight > b.weight) return 1;
            if (a.name < b.name) return -1;
            if (a.name > b.name) return 1;
            // Keep the incoming order for identical item names.
            return a.index - b.index;
        });
        for (index in 0...rows.length) keys[index] = rows[index].key;
        return keys;
    }

    static function priority(name:String):Int {
        if (name.indexOf("health shot") >= 0) return 1;
        if (name.indexOf("mana shot") >= 0) return 2;
        if (name.indexOf("health bomb") >= 0) return 3;
        return 99;
    }
}
