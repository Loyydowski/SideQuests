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
import net.loyydowskimodpack.item.LightCone1Item;
import net.loyydowskimodpack.item.HopeIstheThingWithFeathersItem;
import net.loyydowskimodpack.LoyydowskiModpackMod;

public class LoyydowskiModpackModItems {
	public static final DeferredRegister<Item> REGISTRY = DeferredRegister.create(ForgeRegistries.ITEMS, LoyydowskiModpackMod.MODID);
	public static final RegistryObject<Item> TUBISIOWY_CREAM;
	public static final RegistryObject<Item> FIREFLY_SPAWN_EGG;
	public static final RegistryObject<Item> HOPE_ISTHE_THING_WITH_FEATHERS;
	public static final RegistryObject<Item> LIGHT_CONE_1;
	public static final RegistryObject<Item> EVERNIGHT_SPAWN_EGG;
	public static final RegistryObject<Item> MARCH_SPAWN_EGG;
	static {
		TUBISIOWY_CREAM = REGISTRY.register("tubisiowy_cream", TubisiowyCreamJedzonkoItem::new);
		FIREFLY_SPAWN_EGG = REGISTRY.register("firefly_spawn_egg", () -> new ForgeSpawnEggItem(LoyydowskiModpackModEntities.FIREFLY, -1, -1, new Item.Properties()));
		HOPE_ISTHE_THING_WITH_FEATHERS = REGISTRY.register("hope_isthe_thing_with_feathers", HopeIstheThingWithFeathersItem::new);
		LIGHT_CONE_1 = REGISTRY.register("light_cone_1", LightCone1Item::new);
		EVERNIGHT_SPAWN_EGG = REGISTRY.register("evernight_spawn_egg", () -> new ForgeSpawnEggItem(LoyydowskiModpackModEntities.EVERNIGHT, -1, -1, new Item.Properties()));
		MARCH_SPAWN_EGG = REGISTRY.register("march_spawn_egg", () -> new ForgeSpawnEggItem(LoyydowskiModpackModEntities.MARCH, -1, -1, new Item.Properties()));
	}
	// Start of user code block custom items
	// End of user code block custom items
}