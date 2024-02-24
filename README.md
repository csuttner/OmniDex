# OmniDex
## Goals:
- Explore capabilities of OpenAI developer platform
- Improve skills in SwiftUI and Swift Concurrency using latest APIs
- Write and utilize custom Swift packages to build familiarity with modular architecture
- Use Continuous Delivery with Github Actions for effortless TestFlight and App Store deployment

# Planned UI / Features:

## Chat with AI:
### Conversations List:
- New conversation icon at top right.
- Search bar underneath.
- **Empty state:**
    - Centered text prompting user to start new conversation.
- **Populated state:**
    - Each conversation card is displayed vertically in a scrollable list.
    - Conversations can be deleted with a left swipe, revealing a “delete” option.
    - **Card UI:**
        - Model symbol placed on left (GPT 3.5, 4, etc).
        - Conversation summary and timestamp positioned to the right of the avatar.
        - Chevron to denote ability to navigate to that conversation.

### Conversation Screen:
- Hides tab bar on appearance.
- Text input field spans the width of the screen, with a microphone icon on the right for voice input.
    - This field grows in height as the user types their message.
- Attachment button (camera icon) positioned on the left for uploading images.
    - When an image is queued, a preview card shows up in a horizontally scrollable list above the text input field.
    - Each preview card has an X on the top right to remove from queue.
- **Messages:**
    - User messages are right-aligned and accent-colored, bot messages are left-aligned and gray.
    - Images appear in separate bubbles from text.
    - If a message contains multiple images, it is displayed in a stack. 

## Translation:
### Translation Screen:
- Ability to toggle between text and image recognition.
- **Text translation:**
    - Text input field centered at the top of the screen.
    - Dropdown language selection menu appears below the text input field when tapped.
    - Translation button centered below the language selection dropdown.
- **Image recognition:**
    - Camera interface occupies the center of the screen, with the text display area below it.
    - Contextual information appears dynamically based on recognized image content.
- Audio playback button positioned to the right of the translated text for pronunciation feedback.

## Summarization:
### Summarization Screen:
- Ability to import web link through share functionality.
- Text input field centered at the top of the screen.
- Copy-to-clipboard option appears below the text input field when text is entered.
- Reader view option appears below the text input field when activated.
- Summarize button centered below the copy-to-clipboard option.

## Image Generation:
### Generated Image Library:
- Grid of generated images.
- New image icon in top right, similar to messages.
- Edit button in top left.
    - Tapping turns grid items into edit mode, where they can be selected and deleted.
- Search bar for querying prompts.
- Tapping on an image brings up a detail screen.
### Image Generation Screen:
- **New query state:**
    - Text input field centered at the top of the screen.
    - Prompt builder below this, consisting of a list of tags sectioned by category.
        - Tapping on a tag adds its string to the text input.
- On result received, present detail screen.
### Detail Screen: 
- Fullscreen image (carousel for multiple images) and prompt below it.

# Settings:
- Change profile picture.
- Theme options.
- Storage management.
    - Usage breakdown.
    - Options to delete all conversations and images.
        - Alert that action can’t be undone.
- Manage subscription:
    - Subscription tiers with selected option highlighted.
    - Ability to change subscription or cancel.
- Notifications:
    - Toggle switches for enabling/disabling notifications are listed vertically.
        - App updates / new features.
        - Subscription re-enrollment reminder.
