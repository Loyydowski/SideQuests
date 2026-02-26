package net.loyydowskimodpack.item;

import net.minecraftforge.registries.ForgeRegistries;
import net.loyydowskimodpack.init.LoyydowskiModpackModSounds;
import net.minecraft.world.item.RecordItem;
import net.minecraft.world.item.Item;
import net.minecraft.resources.ResourceLocation;

public class HopeIstheThingWithFeathersItem extends RecordItem {
    public HopeIstheThingWithFeathersItem() {
super(
    0,
    () -> LoyydowskiModpackModSounds.SONG1.get(),
    new Item.Properties().stacksTo(1),
    3500
);
    }
}