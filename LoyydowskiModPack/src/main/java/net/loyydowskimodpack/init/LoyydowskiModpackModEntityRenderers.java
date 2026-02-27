/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.loyydowskimodpack.init;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.eventbus.api.SubscribeEvent;
import net.minecraftforge.client.event.EntityRenderersEvent;
import net.minecraftforge.api.distmarker.Dist;

import net.loyydowskimodpack.client.renderer.MarchRenderer;
import net.loyydowskimodpack.client.renderer.FugueRenderer;
import net.loyydowskimodpack.client.renderer.FireflyRenderer;
import net.loyydowskimodpack.client.renderer.EvernightRenderer;

@Mod.EventBusSubscriber(bus = Mod.EventBusSubscriber.Bus.MOD, value = Dist.CLIENT)
public class LoyydowskiModpackModEntityRenderers {
	@SubscribeEvent
	public static void registerEntityRenderers(EntityRenderersEvent.RegisterRenderers event) {
		event.registerEntityRenderer(LoyydowskiModpackModEntities.FIREFLY.get(), FireflyRenderer::new);
		event.registerEntityRenderer(LoyydowskiModpackModEntities.EVERNIGHT.get(), EvernightRenderer::new);
		event.registerEntityRenderer(LoyydowskiModpackModEntities.MARCH.get(), MarchRenderer::new);
		event.registerEntityRenderer(LoyydowskiModpackModEntities.FUGUE.get(), FugueRenderer::new);
	}
}