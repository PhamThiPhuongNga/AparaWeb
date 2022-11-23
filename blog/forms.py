from django import forms
from .models import Comment 
class CommentForm (forms.ModelForm):
    def __init__(self, *args, **kwargs):
        self.author = kwargs.pop('author', None)
        self.detaillocation = kwargs.pop('detaillocation', None)
        super().__init__(*args, **kwargs)
    # def save(self, commit=True):
    #     comment = super().save(commit=False)
    #     comment.author = self.author
    #     comment.detaillocation = self.detaillocation
    #     comment.save()
    class Meta:
        model = Comment
        fields = ('body','rating')
        # widgets={
        #     'rating':forms.TextInput(attrs={'type':'range','step':'1','min':'1','max':'5','class':'submit_star'})

class UploadFileForm(forms.Form):
    image = forms.FileField(widget=forms.ClearableFileInput(attrs={'multiple': True}))

    