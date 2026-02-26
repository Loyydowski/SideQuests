/*
 *    MCreator note: This file will be REGENERATED on each build.
 */
package net.loyydowskimodpack.init;

import net.minecraftforge.registries.RegistryObject;
import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.registries.DeferredRegister;

import net.minecraft.sounds.SoundEvent;
import net.minecraft.resources.ResourceLocation;

import net.loyydowskimodpack.LoyydowskiModpackMod;

public class LoyydowskiModpackModSounds {
	public static final DeferredRegister<SoundEvent> REGISTRY = DeferredRegister.create(ForgeRegistries.SOUND_EVENTS, LoyydowskiModpackMod.MODID);
	public static final RegistryObject<SoundEvent> FIREFLYHIT = REGISTRY.register("fireflyhit", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "fireflyhit")));
	public static final RegistryObject<SoundEvent> FIREFLYDYING = REGISTRY.register("fireflydying", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "fireflydying")));
	public static final RegistryObject<SoundEvent> FIREFLYIDLE = REGISTRY.register("fireflyidle", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "fireflyidle")));
}