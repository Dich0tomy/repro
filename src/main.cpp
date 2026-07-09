#include <RmlUi/Backends/RmlUi_Backend.h>
#include <RmlUi/Core.h>

#include <RmlUi/Backends/RmlUi_Platform_GLFW.h>
#include <RmlUi/Backends/RmlUi_Renderer_GL3.h>

// Slightly modified example from the RmlUi repo

struct ApplicationData {
  bool show_text = true;
  Rml::String animal = "dog";
} my_data;

auto main() -> int {
  // Constructs the system and render interfaces, creates a window, and attaches
  // the renderer.
  if (not Backend::Initialize("Demo Sample", 1280, 720, true)) {
    return -1;
  }

  Rml::SetSystemInterface(Backend::GetSystemInterface());
  Rml::SetRenderInterface(Backend::GetRenderInterface());

  Rml::Initialise();

  // Create a context to display documents within.
  Rml::Context *context = Rml::CreateContext("main", Rml::Vector2i(1280, 720));

  Rml::LoadFontFace("./font/LatoLatin-Regular.ttf");
  Rml::LoadFontFace("./font/NotoEmoji-Regular.ttf", true);

  // Set up data bindings to synchronize application data.
  if (Rml::DataModelConstructor constructor =
          context->CreateDataModel("animals")) {
    constructor.Bind("show_text", &my_data.show_text);
    constructor.Bind("animal", &my_data.animal);
  }

  // Now we are ready to load our document.
  Rml::ElementDocument *document =
      context->LoadDocument("./res/hello_world.rml");
  document->Show();

  // Replace and style some text in the loaded document.
  Rml::Element *element = document->GetElementById("world");
  element->SetInnerRML(reinterpret_cast<char const *>(u8"🌍"));
  element->SetProperty("font-size", "1.5em");

  bool exit_application = false;
  while (!exit_application) {
    // Update the context to reflect any changes resulting from input events,
    // animations, modified and added elements, or changed data in data
    // bindings.
    context->Update();

    // Render the user interface. All geometry and other rendering commands are
    // now submitted through the render interface.
    context->Render();
  }

  Rml::Shutdown();
}
