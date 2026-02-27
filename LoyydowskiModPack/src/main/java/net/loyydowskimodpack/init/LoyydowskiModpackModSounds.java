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
	public static final RegistryObject<SoundEvent> MUSIC1 = REGISTRY.register("music1", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "music1")));
	public static final RegistryObject<SoundEvent> SONG1 = REGISTRY.register("song1", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "song1")));
	public static final RegistryObject<SoundEvent> IDLEFIREFLY2 = REGISTRY.register("idlefirefly2", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "idlefirefly2")));
	public static final RegistryObject<SoundEvent> IDLEFIREFLY3 = REGISTRY.register("idlefirefly3", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "idlefirefly3")));
	public static final RegistryObject<SoundEvent> EVERNIGHTDYING = REGISTRY.register("evernightdying", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "evernightdying")));
	public static final RegistryObject<SoundEvent> EVERNIGHTHIT1 = REGISTRY.register("evernighthit1", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "evernighthit1")));
	public static final RegistryObject<SoundEvent> EVERNIGHTHIT2 = REGISTRY.register("evernighthit2", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "evernighthit2")));
	public static final RegistryObject<SoundEvent> EVERNIGHTHIT3 = REGISTRY.register("evernighthit3", () -> SoundEvent.createVariableRangeEvent(new ResourceLocation("loyydowski_modpack", "evernighthit3")));
}