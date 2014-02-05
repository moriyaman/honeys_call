class CustomCell < UITableViewCell
 
  attr_accessor :primaryLabel
  attr_accessor :secondaryLabel
  attr_accessor :user_image
 
  def createLabels

    image = UIImage.imageNamed("oka.png")
    @user_image = UIImageView.alloc.initWithImage(image)
    @user_image.frame = CGRectMake(3, 3, 60, 60)
    @user_image.styleClass = 'user_cell_img'
 
    @primaryLabel = UILabel.alloc.init
    @primaryLabel.textAlignment = UITextAlignmentLeft
    @primaryLabel.font = UIFont.systemFontOfSize(16)
    @primaryLabel.styleClass = 'cell_label'

    @secondaryLabel = UILabel.alloc.init
    @secondaryLabel.textAlignment = UITextAlignmentLeft
    @secondaryLabel.font = UIFont.systemFontOfSize(14)
    @secondaryLabel.styleClass = 'cell_label'

    self.contentView.addSubview(@user_image)
    self.contentView.addSubview(@primaryLabel)
    self.contentView.addSubview(@secondaryLabel)
    self
  end
 
  def layoutSubviews
    super
 
    contentRect = self.contentView.bounds
    boundsX = contentRect.origin.x
 
    @primaryLabel.frame = CGRectMake(boundsX+70, 5, 200, 25)
    @secondaryLabel.frame = CGRectMake(boundsX+70, 30, 100, 15)
  end
 
end

