module WorkoutsHelper
  def self.get_glyph(status)
  	case status
  	when :completed; "glyphicon glyphicon-ok green"
	when :rest; "glyphicon glyphicon-heart-empty green"
	when :excused; "glyphicon glyphicon-asterisk green"
	when :expired; "glyphicon glyphicon-remove red"
	when :open; "glyphicon glyphicon-dashboard green"
  	else
  		"glyphicon glyphicon-question-sign red"
  	end
  end
end
