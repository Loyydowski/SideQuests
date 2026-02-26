/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.mcreator.teletubismod.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;

import net.minecraft.world.item.Item;

import net.mcreator.teletubismod.item.TubiCreamItem;
import net.mcreator.teletubismod.TeletubismodMod;

public class TeletubismodModItems {
	public static final DeferredRegister<Item> REGISTRY = DeferredRegister.create(ForgeRegistries.ITEMS, TeletubismodMod.MODID);
	public static final RegistryObject<Item> TUBI_CREAM;
	static {
		TUBI_CREAM = REGISTRY.register("tubi_cream", TubiCreamItem::new);
	}
	// Start of user code block custom items
	// End of user code block custom items
}