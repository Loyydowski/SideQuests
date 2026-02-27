/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.loyydowskimodpack.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.fml.event.lifecycle.FMLCommonSetupEvent;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.eventbus.api.SubscribeEvent;
import net.minecraftforge.event.entity.EntityAttributeCreationEvent;

import net.minecraft.world.entity.MobCategory;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.Entity;

import net.loyydowskimodpack.entity.MarchEntity;
import net.loyydowskimodpack.entity.FugueEntity;
import net.loyydowskimodpack.entity.FireflyEntity;
import net.loyydowskimodpack.entity.EvernightEntity;
import net.loyydowskimodpack.LoyydowskiModpackMod;

@Mod.EventBusSubscriber(bus = Mod.EventBusSubscriber.Bus.MOD)
public class LoyydowskiModpackModEntities {
	public static final DeferredRegister<EntityType<?>> REGISTRY = DeferredRegister.create(ForgeRegistries.ENTITY_TYPES, LoyydowskiModpackMod.MODID);
	public static final RegistryObject<EntityType<FireflyEntity>> FIREFLY = register("firefly",
			EntityType.Builder.<FireflyEntity>of(FireflyEntity::new, MobCategory.MONSTER).setShouldReceiveVelocityUpdates(true).setTrackingRange(64).setUpdateInterval(3).setCustomClientFactory(FireflyEntity::new)

					.sized(0.6f, 1.4f));
	public static final RegistryObject<EntityType<EvernightEntity>> EVERNIGHT = register("evernight",
			EntityType.Builder.<EvernightEntity>of(EvernightEntity::new, MobCategory.MONSTER).setShouldReceiveVelocityUpdates(true).setTrackingRange(66).setUpdateInterval(3).setCustomClientFactory(EvernightEntity::new)

					.sized(0.6f, 1.5f));
	public static final RegistryObject<EntityType<MarchEntity>> MARCH = register("march",
			EntityType.Builder.<MarchEntity>of(MarchEntity::new, MobCategory.MONSTER).setShouldReceiveVelocityUpdates(true).setTrackingRange(64).setUpdateInterval(3).setCustomClientFactory(MarchEntity::new)

					.sized(0.6f, 1.5f));
	public static final RegistryObject<EntityType<FugueEntity>> FUGUE = register("fugue",
			EntityType.Builder.<FugueEntity>of(FugueEntity::new, MobCategory.MONSTER).setShouldReceiveVelocityUpdates(true).setTrackingRange(64).setUpdateInterval(3).setCustomClientFactory(FugueEntity::new)

					.sized(0.6f, 1.5f));

	// Start of user code block custom entities
	// End of user code block custom entities
	private static <T extends Entity> RegistryObject<EntityType<T>> register(String registryname, EntityType.Builder<T> entityTypeBuilder) {
		return REGISTRY.register(registryname, () -> (EntityType<T>) entityTypeBuilder.build(registryname));
	}

	@SubscribeEvent
	public static void init(FMLCommonSetupEvent event) {
		event.enqueueWork(() -> {
			FireflyEntity.init();
			EvernightEntity.init();
			MarchEntity.init();
			FugueEntity.init();
		});
	}

	@SubscribeEvent
	public static void registerAttributes(EntityAttributeCreationEvent event) {
		event.put(FIREFLY.get(), FireflyEntity.createAttributes().build());
		event.put(EVERNIGHT.get(), EvernightEntity.createAttributes().build());
		event.put(MARCH.get(), MarchEntity.createAttributes().build());
		event.put(FUGUE.get(), FugueEntity.createAttributes().build());
	}
}