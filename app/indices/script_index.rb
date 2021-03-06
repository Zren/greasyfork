ThinkingSphinx::Index.define :script, :with => :active_record, :delta => ThinkingSphinx::Deltas::DelayedDelta do

	# fields
	indexes name, :sortable => true
	indexes description
	indexes additional_info
	indexes user.name, :as => :author

	# attributes
	has :id, :created_at, :code_updated_at, :total_installs, :daily_installs

	where 'script_type_id = 1 and moderator_deleted = false'

	set_property :field_weights => {
		:name => 10,
		:author => 5,
		:description => 2,
		:additional_info => 1
	}

end
