class Slide
  WIDTH = 1920
  HEIGHT = 1200
  PADDING = 50
  BACKGROUND_COLOR = '#F6F0A1'

  def initialize(image_height: HEIGHT, image_width: WIDTH)
    @starting_image_height = image_height
    @starting_image_width = image_width

  end

  def generate(upper_text: [], lower_text: [], image_path: nil)
    @image_height = @starting_image_height
    @image_width = @starting_image_width
    @base = Magick::Image.new(@image_width, @image_height) { self.background_color = BACKGROUND_COLOR }

    @text = Magick::Draw.new
    @text.font_family = 'helvetica'
    @text.pointsize = 52
    @text.fill = 'black'

    @text.gravity = Magick::NorthGravity
    add_text(upper_text)
    @text.gravity = Magick::SouthGravity
    add_text(lower_text)

    if image_path
      overlay = Magick::Image.read(image_path).first.resize_to_fit(@image_width, @image_height)
      @base.composite!(overlay, Magick::CenterGravity, 0, 0, Magick::OverCompositeOp)
    end

    file = '/tmp/' + rand.to_s.split('.').last + '.jpg'
    @base.write('jpeg:' + file)

    file
  end

  private
  def add_text(text)
    text.each_with_index do |line, index|
      offset=(box_height * index) + (PADDING * (index + 1))
      @text.annotate(@base, 0, 0, 0, offset, line)

    end
    @image_height = @image_height - ((box_height + PADDING)* (text.length + 1))
  end

  def box_height
    metrics = @text.get_type_metrics("The Melbourne Camera Club")
    (metrics.bounds.y2 - metrics.bounds.y1).round
  end

end