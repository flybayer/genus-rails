module ConversationsHelper

  def link_to_rest_of_conversation(conversation)
    return nil if conversation.length < 3

    number_of_messages = conversation.length - 2
    link_string =
      "View #{number_of_messages} more #{ "messsage".pluralize number_of_messages }"

    link_to link_string, [conversation.organization, conversation]
  end

  def empty_feed_notice
    content_tag(:p, "No conversations so far in this group. Why not start one?", class: 'con-empty')
  end

  def link_for_mark_read(conversation)
    link_to 'Mark as read', organization_conversation_path(
      conversation.organization, conversation, read_status: 'read'),
      method: :patch, remote: true
  end

  def conversation_tag_helper(unread, &block)
    if unread
      content_tag(:section, capture(&block), class: "con-conversation con-conversation--unread")
    else
      content_tag(:section, capture(&block), class: "con-conversation")
    end
  end
end
