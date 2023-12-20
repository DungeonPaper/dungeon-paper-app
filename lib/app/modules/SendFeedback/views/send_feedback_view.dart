import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/core/utils/email_address_validator.dart';
import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../data/services/user_provider.dart';
import '../controllers/send_feedback_controller.dart';

class SendFeedbackView extends StatelessWidget {
  const SendFeedbackView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.feedback.title),
        centerTitle: true,
      ),
      floatingActionButton: Consumer<SendFeedbackController>(
        builder: (context, controller, _) =>
            AdvancedFloatingActionButton.extended(
          onPressed:
              !controller.sending ? () => controller.send(context) : null,
          label: Text(tr.feedback.send),
          icon: controller.sending
              ? const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator.adaptive(),
                )
              : const Icon(Icons.send),
        ),
      ),
      body: Consumer2<SendFeedbackController, UserProvider>(
        builder: (context, controller, userProvider, _) => Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (userProvider.isGuest) ...[
                Obx(
                  () => TextFormField(
                    controller: controller.email,
                    validator: (email) => email?.isEmpty ?? true
                        ? null
                        : EmailAddressValidator().validator(email),
                    decoration: InputDecoration(
                      labelText: tr.feedback.form.email.label,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: controller.title,
                textCapitalization: TextCapitalization.sentences,
                validator:
                    StringValidator(minLength: 1, maxLength: 100).validator,
                decoration: InputDecoration(
                  labelText: tr.feedback.form.title.label,
                ),
              ),
              const SizedBox(height: 16),
              RichTextField(
                controller: controller.body,
                minLines: 10,
                maxLines: 10,
                textCapitalization: TextCapitalization.sentences,
                validator:
                    StringValidator(minLength: 1, maxLength: 100).validator,
                decoration: InputDecoration(
                  labelText: tr.feedback.form.body.label,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

