package net.loyydowskimodpack.item;

import net.minecraft.world.item.UseAnim;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Item;
import net.minecraft.world.food.FoodProperties;

public class TubisiowyCreamJedzonkoItem extends Item {
	public TubisiowyCreamJedzonkoItem() {
		super(new Item.Properties().food((new FoodProperties.Builder()).nutrition(5).saturationMod(0.5f).alwaysEat().build()));
	}

}