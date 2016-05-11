module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def glyphicon_span(glyphicon, text)
    content_tag(:span, '', class:"glyphicon glyphicon-#{glyphicon}")+content_tag(:span, text, class:'ml-10')
  end

  def notice_tag(msg="")
    if msg && msg != ''
      content_tag(:div, '', class:'alert alert-info', role:'alert') do
        content_tag(:span, msg)+
        content_tag(:button, class:'close', :'data-dismiss'=>'alert') do
          content_tag(:span, fa_icon('times'), :'aria-hidden'=> 'true')
        end
      end
    end
  end

  def note_tag(msg='')
    if msg && msg != ''
      content_tag(:div, msg, class:'note', id:'note')
    end
  end



  def ceo?
    current_user.role == "ceo"
  end

  def director?
    current_user.role == "director"
  end

  def pm?
    current_user.role == "pm"
  end

  def staff?
    current_user.role == "staff"
  end

  def intern?
    current_user.role == "intern"
  end

  def user_tree_link(user)
    content_tag(:div, '', class:"elem #{user.role}") do
      concat image_tag("#{user.avatar_url(:thumb)}", class:'avatar img-responsive')
      concat link_to(user.realname, '#', class:'title', data:{toggle:'tooltip', placement:'bottom'}, title:"#{user.role.upcase}", )
      concat content_tag(:div, user.username.capitalize, class:'subtitle')
      unless (user.staff? or user.intern?) or user.id == current_user.id
        concat link_to(fa_icon('pencil-square-o'), edit_user_group_path(id:user.id), class:'op')
        concat link_to(fa_icon('recycle'), cancel_group_path(id:user.id), class:'op', data: {:confirm => "确认撤销 #{user.username} 的职务?", text:"原职务：#{user.role}"}, :method => :delete)
      end
    end
  end

    def user_tree(user)
    if user.buddies.length > 0
      content_tag(:li) do
        user_tree_link(user) +
        content_tag(:ul) do
          user.buddies.each do |u|
            concat user_tree(u)
          end
        end
      end
    else
      content_tag(:li, user_tree_link(user))
    end
  end

end
