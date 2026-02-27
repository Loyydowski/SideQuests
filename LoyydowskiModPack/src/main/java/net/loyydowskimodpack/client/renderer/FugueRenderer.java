package net.loyydowskimodpack.client.renderer;

import net.minecraft.resources.ResourceLocation;
import net.minecraft.client.renderer.entity.layers.HumanoidArmorLayer;
import net.minecraft.client.renderer.entity.HumanoidMobRenderer;
import net.minecraft.client.renderer.entity.EntityRendererProvider;
import net.minecraft.client.model.geom.ModelLayers;
import net.minecraft.client.model.HumanoidModel;

import net.loyydowskimodpack.entity.FugueEntity;

public class FugueRenderer extends HumanoidMobRenderer<FugueEntity, HumanoidModel<FugueEntity>> {
	public FugueRenderer(EntityRendererProvider.Context context) {
		super(context, new HumanoidModel<FugueEntity>(context.bakeLayer(ModelLayers.PLAYER)), 0.5f);
		this.addLayer(new HumanoidArmorLayer(this, new HumanoidModel(context.bakeLayer(ModelLayers.PLAYER_INNER_ARMOR)), new HumanoidModel(context.bakeLayer(ModelLayers.PLAYER_OUTER_ARMOR)), context.getModelManager()));
	}

	@Override
	public ResourceLocation getTextureLocation(FugueEntity entity) {
		return new ResourceLocation("loyydowski_modpack:textures/entities/fugue.png");
	}
}