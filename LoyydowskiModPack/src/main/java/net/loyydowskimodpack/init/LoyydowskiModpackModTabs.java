/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.loyydowskimodpack.init;

import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.eventbus.api.SubscribeEvent;
import net.minecraftforge.event.BuildCreativeModeTabContentsEvent;

import net.minecraft.world.item.CreativeModeTabs;
import net.minecraft.world.item.CreativeModeTab;
import net.minecraft.core.registries.Registries;

import net.loyydowskimodpack.LoyydowskiModpackMod;

@Mod.EventBusSubscriber(bus = Mod.EventBusSubscriber.Bus.MOD)
public class LoyydowskiModpackModTabs {
	public static final DeferredRegister<CreativeModeTab> REGISTRY = DeferredRegister.create(Registries.CREATIVE_MODE_TAB, LoyydowskiModpackMod.MODID);

	@SubscribeEvent
	public static void buildTabContentsVanilla(BuildCreativeModeTabContentsEvent tabData) {
		if (tabData.getTabKey() == CreativeModeTabs.FOOD_AND_DRINKS) {
			tabData.accept(LoyydowskiModpackModItems.TUBISIOWY_CREAM.get());
		} else if (tabData.getTabKey() == CreativeModeTabs.SPAWN_EGGS) {
			tabData.accept(LoyydowskiModpackModItems.FIREFLY_SPAWN_EGG.get());
			tabData.accept(LoyydowskiModpackModItems.EVERNIGHT_SPAWN_EGG.get());
			tabData.accept(LoyydowskiModpackModItems.MARCH_SPAWN_EGG.get());
		} else if (tabData.getTabKey() == CreativeModeTabs.COMBAT) {
			tabData.accept(LoyydowskiModpackModItems.LIGHT_CONE_1.get());
		}
	}
}