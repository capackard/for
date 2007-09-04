# This script calls the scaffold generate drive using the 'model' definition here after. 
# It adds the required associtations to the defined ActiveRecords, generate the routes, and
# will (maybe??) modify the controllers to constrain the scope of the requested by nested resources.
#
# WARNING: Dont use unless you understand the purpose of this code. You may loose some source code.
#          This will change you active record and controller files. 
#          We made no effort to ensure that this code is non destructive to any changes you made.
#
#
# The purpose is to generate an application from scratch...not to change an existing application.
# It adds support for nested crud resources as described here [NOT YET IMPLEMENTED]
#    http://ariejan.net/2007/01/23/rails-nested-resource-scaffold/
#    http://earthcode.com/blog/2007/01/nested_crud_resources_in_rails.html


# ==================================
# = Define ActiveRecord meta model =
# ==================================

# Only defines has_many and has_one not belongs_to. belongs_to is generated automatically.
model= {
:User => {
  :columns => {
      'email' => :string,
      'name' => :string,
      'address' => :string,
      'city' => :string,
      'state' => :string,
      'zip' => :string,
      'credit_card_number' => :string,
      },
  :has_many => [:Bid],
  :has_one => [:Seller]
},
:Bid => {
  :columns => {
    'user_id' => :integer,
    'auction_id' => :integer,
    'price' => :float,
    },
    :has_many => [],
    :has_one => []
},
:Seller => {
  :columns => {
  },
  :has_many => [:Auction],
  :has_one => []
},
:Auction => {
  :columns => {
    'title' => :string,
    'duration' => :integer,
    'buy_now_price' => :float,
    'reserve_price' => :float,
    'start_bid' => :float,
    }, 
    :has_many => [:Bid],
    :has_one => [:Item]
},
:Item => {
  :columns => {
    'description' => :string,
    'shipping_options' => :string,
    'payment_options' => :string,
    },
    :has_many => [],
    :has_one => []
}
    
} # model

# ==========================================
# = Auto Complete Columns for Associations =
# ==========================================
model.each do |model_name, definition|
  definition[:has_many].each  {|association|
    model[association][:columns]["#{model_name.to_s.underscore}_id"] = :integer;
  }
  definition[:has_one].each  {|association|
    model[association][:columns]["#{model_name.to_s.underscore}_id"] = :integer;
  }
end


# =========================
# = Generate Scaffolding  =
# =========================

generate_list = []
destroy_list = []
model.each do |model_name, definition|
  columns = definition[:columns].collect {|k,v| "#{k}:#{v.to_s}" }.join(" ")
  cmd = "./script/generate scaffold #{model_name.to_s} #{columns}"
  generate_list << cmd
  puts "Executing: #{cmd}"
  `#{cmd}`   #IMPORTANT: THIS ACTUALLY EXECUTES THE COMMAND!!!
  destroy_list <<  "./script/destroy scaffold #{model_name.to_s} #{columns}"
end
#File.open(File.join(RAILS_ROOT,"generate_scaffolding.rb"), "w") { |f| f.puts generate_list.join("\n") }
File.open(File.join(RAILS_ROOT,"destroy_application.rb"), "w") { |f| f.puts destroy_list.join("\n") }

# =======================================================================
# = Define some generation utility methods. FIXME: move to proper class =
# =======================================================================

# append one line before the 'end' at the end of a file.
def self.append_lines_file(file_name, lines)
  if File.exist?(file_name)
    content = File.read(file_name)
    content_lines = content.split(/end\n$/) #Fixme: may not work on Windows
    content_lines << lines[0]  # one for now
    content_lines << "end"
    # Write it back
    File.open(file_name, "w") { |f| f.puts content_lines.join("\n") }
  end
end

def self.replace_line_in_file(file_name, old_line, new_line)
puts "#{new_line}"
return
  if File.exist?(file_name)
    content = File.read(file_name)
    content_lines = content.split(/end\n$/) #Fixme: may not work on Windows
    content_lines << lines[0]  # one for now
    content_lines << "end"
    # Write it back
    File.open(file_name, "w") { |f| f.puts content_lines.join("\n") }
  end
end

# Doesn't check if association already exists
def self.add_association(active_record, association)
  file = File.join(MODEL_DIR,active_record.tableize.singularize+'.rb')
  append_lines_file file, [association]
end  

def self.get_nested_resources(model)
  nested_resources = []
  model.each do |model_name, definition|
    many = definition[:has_many].collect { |associated| ":#{associated.to_s.tableize}"}.join(",")
    one  = definition[:has_one].collect { |associated| ":#{associated.to_s.tableize.singularize}"}.join(",")
    resource = "  map.resources :#{model_name.to_s.tableize}"
    resource << ", :has_many => [#{many}]" unless many.empty?
    resource << ", :has_one => [#{one}]"   unless one.empty?
    nested_resources << resource    
  end  
  nested_resources.join("\n")
end

def self.add_nested_resource(resource, nested_resource)
  # map.resources :recipes do |recipes|
  #   recipes.resources :ingredients
  # end
  rested_definition = <<-EOS
    map.resources :#{resource} do |#{resource}|
    	#{resource}.resources :#{nested_resource}
    end
  EOS
  replace_line_in_file(File.join(RAILS_ROOT, "config", "routes.rb"), "map.resources :#{resource}", rested_definition)
end
  
MODEL_DIR   = File.join(RAILS_ROOT, "app/models")
def self.active_record_has_many(from, to)
  from = from.to_s
  to   = to.to_s
  add_association(from, "  has_many :#{to.tableize()}")
  active_record_belongs_to(to, from)  
  add_nested_resource(from.tableize.to_sym, to.tableize.to_sym)
end

def self.active_record_has_one(from, to)
  from = from.to_s
  to   = to.to_s
  add_association(from, "  has_one :#{to.tableize().singularize()}")
  active_record_belongs_to(to, from)  
end

def self.active_record_belongs_to(from, to)
  from = from.to_s
  to   = to.to_s
  add_association(from, "  belongs_to :#{to.tableize().singularize()}")
end

def self.action_controller_has_one(from, to)
  # add code to 'constrain' nested resources
end

def self.action_controller_has_many(from, to)
  # add code to 'constrain' nested resources
end
  
# ==========================================
# = Update ActiveRecords (and Controllers) =
# ==========================================  

model.each do |model_name, definition|
  definition[:has_many].each  { |association|
    self.active_record_has_many(model_name, association)
  }
  definition[:has_one].each  { |association|
    self.active_record_has_one(model_name, association)
  }
end
 
puts "Change the routes manually:"
puts self.get_nested_resources(model)