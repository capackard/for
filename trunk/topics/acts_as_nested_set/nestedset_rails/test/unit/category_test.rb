require File.dirname(__FILE__) + '/../test_helper'

class CategoryTest < Test::Unit::TestCase
  fixtures :categories
  
  def test_result_to_attributes_xml
    expected_xml = <<-EOXML
<?xml version="1.0" encoding="UTF-8"?>
<node name="Main Category" id="15" description="">
  <node name="Cameras &amp; Photo" id="16" description="">
    <node name="Bags" id="17" description=""/>
    <node name="Accessories" id="18" description=""/>
    <node name="Analog Cameras" id="19" description=""/>
    <node name="Digital Cameras" id="20" description=""/>
  </node>
  <node name="Cell Phones" id="21" description="">
    <node name="Accessories" id="22" description=""/>
    <node name="Phones" id="23" description=""/>
    <node name="Prepaid Cards" id="24" description=""/>
  </node>
  <node name="Dvds" id="25" description="">
    <node name="Blueray" id="26" description=""/>
    <node name="HD DVD" id="27" description=""/>
    <node name="DVD" id="28" description=""/>
  </node>
</node>
    EOXML
    assert_equal expected_xml, Category.result_to_attributes_xml(Category.root.full_set)
  end
  
  def test_delete
    assert_difference('Category.count', -1) do
      Category.find(17).destroy
    end
  end
  
  def test_update
    category = categories(:categories_bags)
    category.update_attributes(:name => 'Bags and Stuff')
    category.reload
    assert_equal 'Bags and Stuff', category.name
  end
  
  def test_update_root_category
    
    category = categories(:categories_main)
    category.update_attributes(:name => 'Root Category')
    category.reload
    assert_equal 'Root Category', category.name
    
  end
    
end
