package net.loyydowskimodpack.entity;

import net.minecraftforge.registries.ForgeRegistries;
import net.minecraftforge.network.PlayMessages;
import net.minecraftforge.network.NetworkHooks;

import net.minecraft.world.level.levelgen.Heightmap;
import net.minecraft.world.level.Level;
import net.minecraft.world.item.Items;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.ItemUtils;
import net.minecraft.world.entity.monster.Monster;
import net.minecraft.world.entity.ai.goal.target.HurtByTargetGoal;
import net.minecraft.world.entity.ai.goal.RandomStrollGoal;
import net.minecraft.world.entity.ai.goal.RandomLookAroundGoal;
import net.minecraft.world.entity.ai.goal.MeleeAttackGoal;
import net.minecraft.world.entity.ai.goal.FloatGoal;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.entity.ai.attributes.AttributeSupplier;
import net.minecraft.world.entity.SpawnPlacements;
import net.minecraft.world.entity.MobType;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.InteractionHand;
import net.minecraft.tags.BlockTags;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.resources.ResourceLocation;
import net.minecraft.network.protocol.game.ClientGamePacketListener;
import net.minecraft.network.protocol.Packet;
import net.minecraft.world.entity.ai.goal.target.NearestAttackableTargetGoal;
import net.loyydowskimodpack.init.LoyydowskiModpackModEntities;
import net.loyydowskimodpack.init.LoyydowskiModpackModSounds;

public class EvernightEntity extends Monster {
    private static final ResourceLocation[] HURT_SOUNDS = {
        new ResourceLocation("loyydowski_modpack", "evernighthit1"),
        new ResourceLocation("loyydowski_modpack", "evernighthit2"),
        new ResourceLocation("loyydowski_modpack", "evernighthit3")
    };

    private static final ResourceLocation DEATH_SOUND = new ResourceLocation("loyydowski_modpack", "evernightdying");

    private static final ResourceLocation AMBIENT_SOUND = new ResourceLocation("loyydowski_modpack", "evernightidle");

    public EvernightEntity(PlayMessages.SpawnEntity packet, Level world) {
        this(LoyydowskiModpackModEntities.EVERNIGHT.get(), world);
    }

    public EvernightEntity(EntityType<EvernightEntity> type, Level world) {
        super(type, world);
        setMaxUpStep(0.6f);
        xpReward = 0;
        setNoAi(false);
    }

    @Override
    public Packet<ClientGamePacketListener> getAddEntityPacket() {
        return NetworkHooks.getEntitySpawningPacket(this);
    }

    @Override
    protected void registerGoals() {
        super.registerGoals();
        this.goalSelector.addGoal(1, new MeleeAttackGoal(this, 1.2, false) {
            @Override
            protected double getAttackReachSqr(LivingEntity entity) {
                return (double)(this.mob.getBbWidth() * this.mob.getBbWidth() + entity.getBbWidth());
            }
        });
        this.goalSelector.addGoal(2, new RandomStrollGoal(this, 1));
        this.goalSelector.addGoal(4, new RandomLookAroundGoal(this));
        this.goalSelector.addGoal(5, new FloatGoal(this));
        this.targetSelector.addGoal(1, new HurtByTargetGoal(this));
        this.targetSelector.addGoal(2, new NearestAttackableTargetGoal<>(this, Player.class, true));
    }

    @Override
    public MobType getMobType() {
        return MobType.UNDEFINED;
    }

    @Override
    public double getMyRidingOffset() {
        return -0.35D;
    }

    @Override
    protected void dropCustomDeathLoot(DamageSource source, int looting, boolean recentlyHitIn) {
        super.dropCustomDeathLoot(source, looting, recentlyHitIn);
        this.spawnAtLocation(new ItemStack(Items.IRON_INGOT));
    }

    @Override
    public InteractionResult mobInteract(Player player, InteractionHand hand) {
        ItemStack itemstack = player.getItemInHand(hand);
        if (itemstack.is(Items.BUCKET)) {
            player.playSound(SoundEvents.COW_MILK, 1.0F, 1.0F);
            ItemStack milkBucket = ItemUtils.createFilledResult(itemstack, player, Items.MILK_BUCKET.getDefaultInstance());
            player.setItemInHand(hand, milkBucket);
            return InteractionResult.sidedSuccess(this.level().isClientSide);
        }
        return super.mobInteract(player, hand);
    }

    @Override
    public int getAmbientSoundInterval() {
        return 200 + this.random.nextInt(200);
    }

    @Override
    public float getVoicePitch() {
        return 1.0F;
    }

    @Override
    public void playAmbientSound() {
        SoundEvent sound = this.getAmbientSound();
        if (sound != null) {
            this.playSound(sound, this.getSoundVolume(), 1.0F);
        }
    }

    @Override
    protected void playHurtSound(DamageSource source) {
        SoundEvent sound = this.getHurtSound(source);
        if (sound != null) {
            this.playSound(sound, this.getSoundVolume(), 1.0F);
        }
    }

    @Override
    public void die(DamageSource source) {
        SoundEvent sound = this.getDeathSound();
        if (sound != null) {
            this.playSound(sound, this.getSoundVolume(), 1.0F);
        }
        super.die(source);
    }

    @Override
    public SoundEvent getAmbientSound() {
        return ForgeRegistries.SOUND_EVENTS.getValue(AMBIENT_SOUND);
    }

    @Override
    public SoundEvent getHurtSound(DamageSource ds) {
        ResourceLocation soundLocation = HURT_SOUNDS[this.random.nextInt(HURT_SOUNDS.length)];
        return ForgeRegistries.SOUND_EVENTS.getValue(soundLocation);
    }

    @Override
    public SoundEvent getDeathSound() {
        return LoyydowskiModpackModSounds.EVERNIGHTDYING.get();
    }

    public static void init() {
        SpawnPlacements.register(LoyydowskiModpackModEntities.EVERNIGHT.get(), SpawnPlacements.Type.ON_GROUND, Heightmap.Types.MOTION_BLOCKING_NO_LEAVES,
                (entityType, world, reason, pos, random) -> (world.getBlockState(pos.below()).is(BlockTags.ANIMALS_SPAWNABLE_ON) && world.getRawBrightness(pos, 0) > 8));
    }

    public static AttributeSupplier.Builder createAttributes() {
        AttributeSupplier.Builder builder = Mob.createMobAttributes();
        builder = builder.add(Attributes.MOVEMENT_SPEED, 0.3);
        builder = builder.add(Attributes.MAX_HEALTH, 10);
        builder = builder.add(Attributes.ARMOR, 0);
        builder = builder.add(Attributes.ATTACK_DAMAGE, 3);
        builder = builder.add(Attributes.FOLLOW_RANGE, 16);
        return builder;
    }
}