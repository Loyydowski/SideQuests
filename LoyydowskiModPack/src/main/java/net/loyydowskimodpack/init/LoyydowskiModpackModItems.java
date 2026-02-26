/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.loyydowskimodpack.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.common.ForgeSpawnEggItem;

import net.minecraft.world.item.Item;

import net.loyydowskimodpack.item.TubisiowyCreamJedzonkoItem;
import net.loyydowskimodpack.LoyydowskiModpackMod;

public class LoyydowskiModpackModItems {
	public static final DeferredRegister<Item> REGISTRY = DeferredRegister.create(ForgeRegistries.ITEMS, LoyydowskiModpackMod.MODID);
	public static final RegistryObject<Item> TUBISIOWY_CREAM;
	public static final RegistryObject<Item> FIREFLY_SPAWN_EGG;
	static {
		TUBISIOWY_CREAM = REGISTRY.register("tubisiowy_cream", TubisiowyCreamJedzonkoItem::new);
		FIREFLY_SPAWN_EGG = REGISTRY.register("firefly_spawn_egg", () -> new ForgeSpawnEggItem(LoyydowskiModpackModEntities.FIREFLY, -1, -1, new Item.Properties()));
	}
	// Start of user code block custom items
	// End of user code block custom items
}